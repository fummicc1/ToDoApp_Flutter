import 'package:today_do/bloc/base.dart';
import 'package:today_do/model/todo.dart';

class ToDoTileBLoC with BaseBLoC<bool, bool> {
  final ToDoModel model;

  ToDoTileBLoC(this.model) {
    actionController.stream.listen((value) {
      final ref = model.ref;
      repository.update({
        "is_done": value,
      }, ref).catchError((error) => baseController.addError(error)).then((_) {
        baseController.add(value);
      });
    });
  }
}
