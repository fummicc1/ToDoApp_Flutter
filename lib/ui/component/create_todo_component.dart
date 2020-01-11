import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/create_todo.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class CreateToDoComponent extends StatefulWidget {
  @override
  _CreateToDoComponentState createState() => _CreateToDoComponentState();
}

class _CreateToDoComponentState extends State<CreateToDoComponent> {

  final format = DateFormat("yyyy/MM/dd HH:mm");

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CreateToDoBLoC>(context);

    return StreamBuilder<UploadStatus>(
      stream: bloc.baseStream,
      initialData: UploadStatus.Yet,
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
            case UploadStatus.Yet:
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

                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: DateTimeField(
                      decoration: InputDecoration(
                        hintText: "期限を設定",
                      ),
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final now = DateTime.now();
                        final lastDate = DateTime(now.year, now.month, now.day + 1);
                        final date = await showDatePicker(context: context, initialDate: currentValue ?? now, firstDate: currentValue ?? now, lastDate: lastDate);
                        if (date != null) {
                          final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(currentValue ?? now));
                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                  ),
                ],
              );
            case UploadStatus.Ready:
              return Center(child: FlatButton.icon(onPressed: null, icon: Icon(Icons.save), label: null),);
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
