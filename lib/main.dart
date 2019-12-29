import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/todo_list_bloc.dart';
import 'package:today_do/ui/page/create_todo_page.dart';
import 'package:today_do/ui/page/todo_list_page.dart';
import 'ui/page/todo_list_page.dart';

void main() => runApp(MaterialApp(
      title: "ToDayDo",
      theme: ThemeData(canvasColor: Colors.white, primarySwatch: Colors.amber),
      home: MyApp(),
      routes: {
        "/create_todo": (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("ToDo作成"),
            ),
            body: CreateToDoPage(),
          );
        },
      },
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDoリスト"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("/create_todo");
            },
          ),
        ],
      ),
      body: Provider<ToDoListBLoC>(
        create: (_) => ToDoListBLoC(),
        dispose: (_, bloc) => bloc.dispose(),
        child: ToDoListPage(),
      ),
    );
  }
}
