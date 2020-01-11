import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:today_do/model/user.dart';

import '../model/todo.dart';
import 'base.dart';

enum UploadStatus {
  Yet,
  Ready,
  Uploading,
  Done,
}

class CreateToDoBLoC with BaseBLoC<UploadStatus, void> {

  BehaviorSubject<TimeOfDay> _deadlineSubject = BehaviorSubject();
  Sink<TimeOfDay> get deadlineSink => _deadlineSubject.sink;
  Stream<TimeOfDay> get deadlineStream => _deadlineSubject.stream;

  BehaviorSubject<String> _todoContentSubject = BehaviorSubject();
  Sink<String> get todoContentSink => _todoContentSubject.sink;

  BehaviorSubject<DateTime> _todoDeadlineSubject = BehaviorSubject();
  Sink<DateTime> get todoDeadlineSink => _todoDeadlineSubject.sink;

  DocumentReference _userRef;

  CreateToDoBLoC() {

    if (_todoContentSubject.value.isNotEmpty && _todoDeadlineSubject.value != null) {
      baseController.add(UploadStatus.Ready);
    }

    actionController.stream.listen((value) {

      baseController.add(UploadStatus.Uploading);

      ToDoModel todo = _createToDo(_todoContentSubject.value, _userRef);
      repository.create(todo).catchError((error) {
        baseController.addError(error);
      }).then((_) {
        baseController.add(UploadStatus.Done);
      });
    });

    FirebaseAuth.instance.currentUser()
        .then((user) => user.uid)
        .then((uid) =>
    _userRef =
        Firestore.instance.collection(UserModel.collectionName).document(uid));
  }

  ToDoModel _createToDo(String text, DocumentReference sender, {DateTime selectedTime}) {

    DateTime deadline;

    if (selectedTime == null) {
      DateTime currentDate = DateTime.now();

      int year = currentDate.year;
      int month = currentDate.month;
      int day = currentDate.day;

      if (month == 2) {
        if (isLeapYear(year)) {
          if (day == 28) {
            day++;
          } else if (day == 29) {
            month = 3;
            day = 1;
          }
        } else {
          if (day == 28) {
            month = 3;
            day = 1;
          }
        }
      } else if (month == 12 && day == 31) {
        year++;
        month = 1;
        day = 1;
      } else if (day == 31 && [1, 3, 5, 7, 8, 10].contains(month)) {
        month++;
        day = 1;
      } else if (day == 30 && [2, 4, 6, 9, 11].contains(month)) {
        month++;
        day = 1;
      } else {
        day++;
      }
      deadline = DateTime(year, month, day);
    } else {

      assert(false);

    }



    return ToDoModel(text, deadline, sender: sender);
  }

  bool isLeapYear(int year) {
    if (year % 100 == 0) {
      if (year % 400 == 0) return true;
      return false;
    }

    if (year % 4 == 0) return true;

    return false;
  }
}