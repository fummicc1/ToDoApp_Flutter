import 'package:today_do/bloc/base.dart';
import 'package:today_do/model/todo.dart';

class ToDoTileBLoC with BaseBLoC<bool, bool> {
  final ToDoModel model;

  ToDoTileBLoC(this.model) {
    actionController.stream.listen((value) {

      if (model.status == ToDoStatus.Failed) {
        baseController.add(null);
        return;
      }

      final ref = model.ref;
      repository.update({
        "is_done": value,
      }, ref).then((_) {
        baseController.add(value);
      });
    });
  }
}
