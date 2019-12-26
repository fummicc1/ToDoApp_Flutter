import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/home_bloc.dart';
import 'package:today_do/bloc/todo_list_bloc.dart';
import 'package:today_do/ui/todo_list_page.dart';
import 'package:today_do/model/user.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    var bloc = Provider.of<HomeBLoC>(context);

    return Provider<HomeBLoC>(
      create: (_) => HomeBLoC(),
      dispose: (_, bloc) => bloc.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("ToDoリスト"),
        ),
        body: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {

    var bloc = Provider.of<HomeBLoC>(context);

    return StreamBuilder<UserModel>(
      stream: bloc.stream,
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return Container(
            child: Text("インジケータ表示"),
          );
        }

        return Provider<ToDoListBLoC>(
          create: (_) => ToDoListBLoC(),
          dispose: (_, bloc) => bloc.dispose(),
          child: ToDoListPage(),
        );

      },
    );

  }
}
