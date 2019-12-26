import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/todo_list_bloc.dart';
import 'package:today_do/model/todo.dart';

class ToDoListComponent extends StatefulWidget {
  @override
  _ToDoListComponentState createState() => _ToDoListComponentState();
}

class _ToDoListComponentState extends State<ToDoListComponent> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<ToDoListBLoC>(context);

    return StreamBuilder<ToDoListModel>(
      stream: bloc.stream,
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return AlertDialog(
            title: Text("ToDoが見つかりませんでした。"),
            content: Text("新しく作成してみませんか？"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "新しく作成",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/create_todo");
                },
              ),
              FlatButton(
                child: Text(
                  "キャンセル",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {},
              )
            ],
          );
        }

        return ListView.builder(
          itemCount: snapShot.data.value.length,
          itemBuilder: (context, index) {
            var todo = snapShot.data.value[index];

            return ListTile(
              title: Text(
                todo.todo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
