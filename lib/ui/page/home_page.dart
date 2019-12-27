import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/home_bloc.dart';
import 'package:today_do/bloc/todo_list_bloc.dart';
import 'package:today_do/ui/component/todo_list_component.dart';
import 'package:today_do/model/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<HomeBLoC>(context);

    return StreamBuilder<UserModel>(
      stream: bloc.stream,
      builder: (context, snapShot) {
        if (!snapShot.hasData) return  CircularProgressIndicator();

        if (snapShot.hasData) {
          bloc.sink.add(snapShot.data);
        }

        return Provider<ToDoListBLoC>(
          create: (_) => ToDoListBLoC(),
          dispose: (_, bloc) => bloc.dispose(),
          child: ToDoListComponent(),
        );
      },
    );
  }
}
