import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:today_do/model/todo.dart';
import 'package:today_do/model/user.dart';

import 'base.dart';

class ToDoListBLoC with BaseBLoC<ToDoListModel, void> {
  final BehaviorSubject<UserModel> _userController = BehaviorSubject();
  Stream<UserModel> get userStream => _userController.stream;
  Sink<UserModel> get userSink => _userController.sink;

  BehaviorSubject<UserModel> _userPersistController = BehaviorSubject();
  Stream<UserModel> get userPersistStream => _userPersistController.stream;
  Sink<UserModel> get userPersistSink => _userPersistController.sink;

  ToDoListBLoC() {
    Stream<UserModel> _userStream = repository.listenUserState();

    userStream.listen((user) {
      if (user == null)
        repository.signinAnonymously();
      else {
        Query query = Firestore.instance
            .collection(ToDoModel.collectionName)
            .where(
                "sender",
                isEqualTo: Firestore.instance
                    .collection(UserModel.collectionName)
                    .document(user.uid));

        if (baseController.hasListener) baseController.close();

        var _baseStream = repository.listenQuery(query).map((snapShot) {

          if (snapShot.documents.isEmpty) return null;

          ToDoListModel list = ToDoListModel([]);

          for (int i = 0; i < snapShot.documents.length; i++) {
            var data = snapShot.documents[i].data;

            list.value.add(ToDoModel.fromJson(data));
          }
          return list;
        });

        baseController.addStream(_baseStream);
      }
    });

    _userController.addStream(_userStream);

    userPersistStream.listen((user) {
      user.loginDate = DateTime.now();
      repository.create(user);
    });
  }

  List<ToDoModel> getToDoStatus(ToDoListModel model) => model.value.where((todo) => todo.status == ToDoStatus.ToDo).toList();
  List<ToDoModel> getDoneStatus(ToDoListModel model) => model.value.where((todo) => todo.status == ToDoStatus.Done).toList();
  List<ToDoModel> getFailedStatus(ToDoListModel model) => model.value.where((todo) => todo.status == ToDoStatus.Failed).toList();

  @override
  void dispose() {
    super.dispose();
    _userController?.close();
    _userPersistController?.close();
  }
}
