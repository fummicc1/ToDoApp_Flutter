
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:today_do/model/base.dart';

enum ToDoStatus {
  ToDo,
  Done,
  Failed,
}

class ToDoModel with BaseModel {

  static const String collectionName = "todos";

  String todo;
  DateTime deadline;
  bool isDone;

  ToDoStatus get status {
    final DateTime current = DateTime.now();
    if (isDone) return ToDoStatus.Done;
    if (current.isAfter(deadline)) return ToDoStatus.Failed;
    if (current.isBefore(deadline)) return ToDoStatus.ToDo;
  }

  DocumentReference sender;

  ToDoModel(String todo, DateTime deadline, {DocumentReference sender, bool isDone = false}) {
    this.ref = Firestore.instance.collection(ToDoModel.collectionName).document();
    this.todo = todo;
    this.deadline = deadline;
    this.sender = sender;
    this.isDone = isDone;
  }

  ToDoModel.fromJson(Map<String, dynamic> json) {

    print("json: $json");

    todo = json["todo"];

    isDone = json["is_done"];

    if (json["deadline"] is Timestamp) {
      deadline = json["deadline"].toDate();
    }

    if (json["ref"] is DocumentReference) {
      ref = json["ref"];
    }

    if (json["sender"] is DocumentReference) {
      sender = json["sender"];
    }
  }

  @override
  Map<String, dynamic> get json => {
    "todo": todo,
    "deadline": deadline,
    "ref": ref,
    "sender": sender,
    "is_done": isDone,
  };
}

class ToDoListModel with BaseModel {
  List<ToDoModel> value;

  ToDoListModel(this.value);

  @override
  Map<String, dynamic> get json => {
    "todo_list": value.map((todo) => todo.json)
  };
}