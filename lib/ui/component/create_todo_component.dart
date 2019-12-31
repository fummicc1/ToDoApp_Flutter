import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/create_todo.dart';

class CreateToDoComponent extends StatefulWidget {
  @override
  _CreateToDoComponentState createState() => _CreateToDoComponentState();
}

class _CreateToDoComponentState extends State<CreateToDoComponent> {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CreateToDoBLoC>(context);

    return StreamBuilder<UploadStatus>(
      stream: bloc.baseStream,
      initialData: UploadStatus.Idle,
      builder: (context, snapShot) {
        if (snapShot.hasError) {
          SnackBar snackBar = SnackBar(
            content: Text("ToDoを保存することができませんでした。お手数ですがもう一度お試しください。"),
            action: SnackBarAction(
                label: "リトライ",
                onPressed: () {
                  bloc.baseSink.add(null);
                }),
          );

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          });
        }

        if (snapShot.hasData) {
          switch (snapShot.data) {
            case UploadStatus.Idle:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "今日やることを決めましょう",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                          )),
                      onSubmitted: (text) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("この内容で保存しますか？"),
                                content: Text(text),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("キャンセル"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("保存する"),
                                    onPressed: () {
                                      bloc.baseSink.add(text);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ),
                  Center(
                    child: StreamBuilder<bool>(
                        stream: bloc.isSwitchOnStream,
                        initialData: false,
                        builder: (context, switchSnapshot) {
                          if (switchSnapshot.data)
                            _showTimePicker(context, bloc);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              StreamBuilder<TimeOfDay>(
                                  stream: bloc.deadlineStream,
                                  builder: (context, timeSnapShot) {
                                    if (!timeSnapShot.hasData ||
                                        !switchSnapshot.data)
                                      return Text("オプション: 締め切りの時刻を設定する");

                                    return Text(timeSnapShot.data.format(context));
                                  }),
                              Switch(
                                value: switchSnapshot.data,
                                onChanged: (value) {
                                  bloc.isSwitchOnSink.add(value);
                                },
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              );
            case UploadStatus.Uploading:
              return Center(child: CircularProgressIndicator());
            case UploadStatus.Done:
              SnackBar snackBar = SnackBar(
                content: Text("ToDoを保存しました！"),
                action: SnackBarAction(
                    label: "リスト画面へ",
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              });
              return Center(
                child: IconButton(
                  icon: Icon(Icons.done),
                  iconSize: 64,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              );
          }
        }
        return Container();
      },
    );
  }

  void _showTimePicker(BuildContext context, CreateToDoBLoC bloc) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),).then((time) {
        bloc.deadlineSink.add(time);
      });
    });
  }
}
