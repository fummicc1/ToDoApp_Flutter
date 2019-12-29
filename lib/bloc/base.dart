import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:today_do/repository/repository.dart';

// BLoC
// V: Output, A: Input
mixin BaseBLoC<V, A> {

  @protected Repository repository = Repository();

  @protected StreamController<V> controller = BehaviorSubject<V>();
  Stream<V> get baseStream => controller.stream;

  @protected StreamController<A> actionController = StreamController<A>();
  Sink<A> get baseSink => actionController.sink;

  void dispose() {
    controller.close();
    actionController.close();
  }
}