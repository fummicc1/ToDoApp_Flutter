import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/todo_list_bloc.dart';
import 'package:today_do/bloc/todo_tile_bloc.dart';
import 'package:today_do/model/todo.dart';
import 'package:today_do/ui/component/todo_tile_component.dart';

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
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.value.isEmpty)
            return _promptCreatingToDo(context);

          return TabBarView(
            children: <Widget>[
              _getListView(bloc.getToDoStatus(snapshot.data)),
              _getListView(bloc.getDoneStatus(snapshot.data)),
              _getListView(bloc.getFailedStatus(snapshot.data)),
            ],
          );
        });
  }

  Widget _promptCreatingToDo(BuildContext context) {
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
  }

  Widget _getListView(List<ToDoModel> list) => ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        var todo = list[index];
        return Provider<ToDoTileBLoC>(
          create: (_) => ToDoTileBLoC(list[index]),
          dispose: (_, bloc) => bloc.dispose(),
          child: ToDoTileComponent(),
        );
      });
}
