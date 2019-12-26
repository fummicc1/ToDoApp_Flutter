import 'dart:async';
import 'package:today_do/model/base.dart';
import 'package:today_do/repository/repository.dart';

// ビジネスロジックコンポーネント
mixin BaseBLoC<V extends BaseModel, A> {

  Repository repository = Repository();

  StreamController<V> controller = StreamController<V>();
  Stream<V> get stream => controller.stream;

  StreamController<A> actionController = StreamController<A>();
  Sink<A> get sink => actionController.sink;

  void dispose() {
    controller.close();
    actionController.close();
  }
}