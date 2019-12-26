import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/todo_list_bloc.dart';
import 'package:today_do/model/todo.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  @override
  Widget build(BuildContext context) {

    var bloc = Provider.of<ToDoListBLoC>(context);

    return StreamBuilder<ToDoListModel>(
      stream: bloc.stream,
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return Center(
            child: Text("Loading..."),
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
