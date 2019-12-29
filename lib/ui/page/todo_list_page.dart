import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/todo_list_bloc.dart';
import 'package:today_do/ui/component/todo_list_component.dart';
import 'package:today_do/model/user.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<ToDoListBLoC>(context);

    return StreamBuilder<UserModel>(
      stream: bloc.userStream,
      builder: (context, snapShot) {
        if (!snapShot.hasData) return  Center(child: CircularProgressIndicator());

        if (snapShot.hasData) {
          bloc.userPersistSink.add(snapShot.data);
        }

        return ToDoListComponent();
      },
    );
  }
}
