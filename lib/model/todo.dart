
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:today_do/model/base.dart';

class ToDoModel with BaseModel {

  static const String collectionName = "todos";

  String todo;
  DateTime deadline;
  DocumentReference sender;

  ToDoModel(String todo, DateTime deadline, [DocumentReference sender]) {
    this.ref = Firestore.instance.collection(ToDoModel.collectionName).document();
    this.todo = todo;
    this.deadline = deadline;
    this.sender = sender;
  }

  ToDoModel.fromJson(Map<String, dynamic> json) {

    print("json: $json");

    todo = json["todo"];

    if (json["deadline"] is Timestamp) {
      deadline = json["deadline"].toDate();
    }

    if (json["ref"] is DocumentReference) {
      ref = json["ref"];
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

  ToDoListModel(this.value);

  @override
  // TODO: implement json
  Map<String, dynamic> get json => {
    "todo_list": value.map((todo) => todo.json)
  };
}