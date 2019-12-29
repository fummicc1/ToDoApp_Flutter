import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/app_bloc.dart';
import 'package:today_do/bloc/create_todo.dart';
import 'package:today_do/bloc/todo_list_bloc.dart';
import 'package:today_do/ui/page/create_todo_page.dart';
import 'package:today_do/ui/page/todo_list_page.dart';

import 'bloc/home_bloc.dart';
import 'ui/page/todo_list_page.dart';

void main() => runApp(
  Provider<AppBLoC>(
    create: (_) => AppBLoC(ToDoListBLoC(), CreateToDoBLoC(), HomeBLoC()),
    dispose: (_, bloc) => bloc.dispose(),
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final appBLoC = Provider.of<AppBLoC>(context);

    return MaterialApp(
        title: 'Flutter Demo',
        theme:
            ThemeData(canvasColor: Colors.white, primarySwatch: Colors.amber),
        home: Scaffold(
          appBar: AppBar(
            title: Text("ToDoリスト"),
            actions: <Widget>[
              StreamBuilder<bool>(
                stream: appBLoC.toDoListBLoC.dialogFlagStream,
                builder: (context, snapShot) {
                  if (snapShot.hasData && !snapShot.data) {
                    return IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/create_todo");
                      },
                    );
                  }
                  return Container();
                },
              )
          ],
          ),
          body: Provider<HomeBLoC>(
            create: (_) => appBLoC.homeBLoC,
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
