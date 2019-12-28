import 'dart:async';
import 'package:flutter/material.dart';
import 'package:today_do/model/base.dart';
import 'package:today_do/repository/repository.dart';

// BLoC
// V: Output, A: Input
mixin BaseBLoC<V, A> {

  @protected Repository repository = Repository();

  @protected StreamController<V> controller = StreamController<V>();
  Stream<V> get baseStream => controller.stream;

  @protected StreamController<A> actionController = StreamController<A>();
  Sink<A> get baseSink => actionController.sink;

  void dispose() {
    controller.close();
    actionController.close();
  }
}