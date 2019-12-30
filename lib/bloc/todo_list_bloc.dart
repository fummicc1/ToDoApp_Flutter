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

  StreamController<int> _tabIndexStreamController = BehaviorSubject.seeded(0);
  Sink<int> get tabIndexSink => _tabIndexStreamController.sink;

  ToDoListModel _model;


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

          _model = list;
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

    _tabIndexStreamController.stream.listen((index) {

      var values;

      if (index == 0) {

        values = _model.value.where((todoModel) => todoModel.status == ToDoStatus.ToDo);

      } else if (index == 1) {

        values = _model.value.where((todoModel) => todoModel.status == ToDoStatus.Done);

      } else if (index == 2) {

         values = _model.value.where((todoModel) => todoModel.status == ToDoStatus.Failed);

      }

      if (values == null) return;

      baseController.add(values);

    });
  }

  @override
  void dispose() {
    super.dispose();
    _userController?.close();
    _userPersistController?.close();
  }
}
