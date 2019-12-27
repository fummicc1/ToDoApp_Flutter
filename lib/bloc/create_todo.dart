import 'dart:async';

import '../model/todo.dart';
import 'base.dart';

class CreateToDoBLoC with BaseBLoC<ToDoModel, void> {
  StreamController<String> _textController = StreamController<String>();
  Stream<String> get textStream => _textController.stream;
  Sink<String> get textSink => _textController.sink;
}