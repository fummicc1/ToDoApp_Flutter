import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/todo_list_bloc.dart';
import 'package:today_do/model/todo.dart';

class ToDoListComponent extends StatefulWidget {
  @override
  _ToDoListComponentState createState() => _ToDoListComponentState();
}

class _ToDoListComponentState extends State<ToDoListComponent>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ToDoListBLoC>(context);

    return StreamBuilder<ToDoListModel>(
      stream: bloc.baseStream,
      builder: (context, todoListSnapShot) {
        if (!todoListSnapShot.hasData)
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



        return ListView.builder(
          itemCount: todoListSnapShot.data.value.length,
          itemBuilder: (context, index) {
            var todo = todoListSnapShot.data.value[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 10,
              child: ListTile(
                leading: Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                title: Text(todo.todo),
              ),
            );
          },
        );

      },
    );
  }

  Widget _createListView(ToDoListBLoC bloc) {

    return StreamBuilder<ToDoListModel>(
      stream: bloc.baseStream,
      builder: (context, snapShot) {



      },
    );

  }
}
