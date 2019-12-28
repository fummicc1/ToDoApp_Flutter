import 'dart:async';

import '../model/todo.dart';
import 'base.dart';

class CreateToDoBLoC with BaseBLoC<ToDoModel, String> {

  CreateToDoBLoC() {
    actionController.stream.listen((text) {
      ToDoModel todo = _createToDo(text);
      repository.create(todo);
    });
  }

  ToDoModel _createToDo(String text) {

    DateTime currentDate = DateTime.now();

    int year = currentDate.year;
    int month = currentDate.month;
    int day = currentDate.day;

    // February
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
    }
    DateTime tomorrow = DateTime(year, month, day);
    return ToDoModel(text, tomorrow);
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