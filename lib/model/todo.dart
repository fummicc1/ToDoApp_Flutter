
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:today_do/model/base.dart';

class ToDoModel with BaseModel {

  String todo;
  DateTime deadline;
  DocumentReference sender;

  ToDoModel(String todo, DateTime deadline) {
    this.ref = Firestore.instance.collection("todo").document();
    this.todo = todo;
    this.deadline = deadline;
  }

  ToDoModel.fromJSON(Map<String, dynamic> json) {
    todo = json["todo"];
    var _deadline = json["deadline"];

    if (_deadline is Timestamp) {
      deadline = _deadline.toDate();
    }


  }

  @override
  Map<String, dynamic> get json => {
    "todo": todo,
    "deadline": deadline,
    "ref": ref
  };
}

class ToDoListModel with BaseModel {
  List<ToDoModel> value;

  ToDoListModel.fromJSON(Map<String, dynamic> json) {
    var _json = json["todo_list"];

    if (_json is List<Map<String, dynamic>>) {
       value = (_json as List<Map<String, dynamic>>).map((json) => ToDoModel.fromJSON(json));
    }
  }

  @override
  // TODO: implement json
  Map<String, dynamic> get json => {
    "todo_list": value.map((todo) => todo.json)
  };
}