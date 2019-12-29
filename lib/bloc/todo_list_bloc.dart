import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:today_do/model/todo.dart';

import 'base.dart';

class ToDoListBLoC with BaseBLoC<ToDoListModel, void> {

  StreamController<bool> _dialogFlagController = StreamController.broadcast();
  Sink<bool> get dialogFlagSink => _dialogFlagController.sink;
  Stream<bool> get dialogFlagStream => _dialogFlagController.stream;

  ToDoListBLoC() {
    CollectionReference ref = Firestore.instance.collection(ToDoModel.collectionName);
    Stream<ToDoListModel> stream = repository.listenCollection(ref).map((snapShot) {

      if (snapShot.documents.isNotEmpty) dialogFlagSink.add(false);

      ToDoListModel list = ToDoListModel([]);

      for (int i = 0; i < snapShot.documents.length; i++) {
        var data = snapShot.documents[i].data;

        list.value.add(ToDoModel.fromJson(data));
      }

      print("List: $list");
      return list;
    });

    controller.addStream(stream);
  }

  @override
  void dispose() {
    super.dispose();
    _dialogFlagController.close();
  }

}