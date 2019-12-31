import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/todo_tile_bloc.dart';
import 'package:today_do/model/todo.dart';

class ToDoTileComponent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var bloc = Provider.of<ToDoTileBLoC>(context);

    return StreamBuilder<bool>(
      stream: bloc.baseStream,
      initialData: false,
      builder: (context, snapshot) {

        if (!snapshot.hasData || snapshot.hasError) return Center(child: CircularProgressIndicator(),);

        return ListTile(
          leading: Checkbox(
            value: snapshot.data,
            onChanged: (value) {
              bloc.baseSink.add(value);
            },
          ),
          title: Text(bloc.model.todo, style: TextStyle(fontSize: 20),),
        );
      }
    );
  }
}
