import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/ui/page/create_todo_page.dart';
import 'package:today_do/ui/page/todo_list_page.dart';

import 'bloc/home_bloc.dart';
import 'ui/page/todo_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme:
            ThemeData(canvasColor: Colors.white, primarySwatch: Colors.amber),
        home: Scaffold(
          appBar: AppBar(
            title: Text("ToDoリスト"),
          ),
          body: Provider<HomeBLoC>(
            create: (_) => HomeBLoC(),
            dispose: (_, bloc) => bloc.dispose(),
            child: ToDoListPage(),
          ),
        ),
        routes: {
          "/create_todo": (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text("ToDo作成"),
              ),
              body: CreateToDoPage(),
            );
          },
        });
  }
}
