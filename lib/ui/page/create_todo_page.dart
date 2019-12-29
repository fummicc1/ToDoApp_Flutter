import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/app_bloc.dart';
import 'package:today_do/bloc/create_todo.dart';
import 'package:today_do/ui/component/create_todo_component.dart';

class CreateToDoPage extends StatefulWidget {
  @override
  _CreateToDoPageState createState() => _CreateToDoPageState();
}

class _CreateToDoPageState extends State<CreateToDoPage> {
  @override
  Widget build(BuildContext context) {
    final appBLoC = Provider.of<AppBLoC>(context);
    return Provider<CreateToDoBLoC>(
      create: (_) => appBLoC.createToDoBLoC,
      dispose: (_, bloc) => bloc.dispose(),
      child: CreateToDoComponent(),
    );
  }
}
