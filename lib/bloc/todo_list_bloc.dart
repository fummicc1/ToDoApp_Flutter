import 'dart:async';
import 'package:flutter/material.dart';
import 'package:today_do/model/todo.dart';

import 'base.dart';

class ToDoListBLoC with BaseBLoC<ToDoListModel, void> {

  StreamController<bool> _dialogFlagController = StreamController();
  Sink<bool> get dialogFlagSink => _dialogFlagController.sink;
  Stream<bool> get dialogFlagStream => _dialogFlagController.stream;

  @override
  void dispose() {
    super.dispose();
    _dialogFlagController.close();
  }

}