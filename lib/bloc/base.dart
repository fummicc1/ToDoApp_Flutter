import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:today_do/repository/repository.dart';

// BLoC
// V: Output, A: Input
mixin BaseBLoC<V, A> {

  @protected Repository repository = Repository();

  @protected BehaviorSubject<V> baseController = BehaviorSubject<V>();
  Stream<V> get baseStream => baseController.stream;

  @protected BehaviorSubject<A> actionController = BehaviorSubject<A>();
  Sink<A> get baseSink => actionController.sink;

  void dispose() {
    baseController?.close();
    actionController?.close();
  }
}