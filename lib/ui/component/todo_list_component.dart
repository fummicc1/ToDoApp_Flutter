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
    final bloc = Provider.of<ToDoListBLoC>(context);

    return StreamBuilder<ToDoListModel>(
      stream: bloc.baseStream,
      builder: (context, todoListSnapShot) {
        return StreamBuilder<bool>(
          initialData: true,
          stream: bloc.dialogFlagStream,
          builder: (context, dialogFlagSnapShot) {
            if (!todoListSnapShot.hasData) {
              if (dialogFlagSnapShot.hasData && !dialogFlagSnapShot.data)
                return Container(
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: RaisedButton(
                        color: Colors.white,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "ToDoを作成",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/create_todo");
                        },
                      ),
                    ));

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
                    onPressed: () {
                      bloc.dialogFlagSink.add(false);
                    },
                  )
                ],
              );
            }

            return ListView.builder(
              itemCount: todoListSnapShot.data.value.length,
              itemBuilder: (context, index) {
                var todo = todoListSnapShot.data.value[index];

                return CheckboxListTile(
                  value: false,
                  title: Text(
                    todo.todo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {

                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
