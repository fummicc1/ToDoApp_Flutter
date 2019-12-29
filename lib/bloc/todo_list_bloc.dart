import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:today_do/model/todo.dart';
import 'package:today_do/model/user.dart';

import 'base.dart';

class ToDoListBLoC with BaseBLoC<ToDoListModel, void> {

  final StreamController<UserModel> _userController = BehaviorSubject();
  Stream<UserModel> get userStream => _userController.stream;
  Sink<UserModel> get userSink => _userController.sink;

  StreamController<UserModel> _userPersistController = PublishSubject();
  Stream<UserModel> get userPersistStream => _userPersistController.stream;
  Sink<UserModel> get userPersistSink => _userPersistController.sink;

  StreamController<bool> _dialogFlagController = BehaviorSubject.seeded(true);
  Sink<bool> get dialogFlagSink => _dialogFlagController.sink;
  Stream<bool> get dialogFlagStream => _dialogFlagController.stream;

  ToDoListBLoC() {

    Stream<UserModel> _userStream = repository.listenUserState();

    userStream.listen((user) {
      if (user == null) repository.signinAnonymously();
    });

    _userController.addStream(_userStream);

    CollectionReference ref = Firestore.instance.collection(ToDoModel.collectionName);
    Stream<ToDoListModel> stream = repository.listenCollection(ref).map((snapShot) {

      if (snapShot.documents.isNotEmpty) dialogFlagSink.add(false);

      ToDoListModel list = ToDoListModel([]);

      for (int i = 0; i < snapShot.documents.length; i++) {
        var data = snapShot.documents[i].data;

        list.value.add(ToDoModel.fromJson(data));
      }
      return list;
    });

    baseController.addStream(stream);

    userPersistStream.listen((user) {
      user.loginDate = DateTime.now();
      repository.create(user);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _dialogFlagController?.close();
    _userController?.close();
    _userPersistController?.close();
  }

}