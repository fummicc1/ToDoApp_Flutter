import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/create_todo.dart';
import 'package:today_do/model/todo.dart';

class CreateToDoComponent extends StatefulWidget {
  @override
  _CreateToDoComponentState createState() => _CreateToDoComponentState();
}

class _CreateToDoComponentState extends State<CreateToDoComponent> {

  @override
  Widget build(BuildContext context) {

    var bloc = Provider.of<CreateToDoBLoC>(context);

    return Container(
      margin: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          labelText: "今日やることを決めましょう",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          )
        ),
        onSubmitted: (text) {
          showDialog(context: context, builder: (_) {
            return AlertDialog(
              title: Text("この内容で保存しますか？"),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    bloc.baseSink.add(text);
                  },
                )
              ],
            );
          });
        },
      ),
    );
  }
}
