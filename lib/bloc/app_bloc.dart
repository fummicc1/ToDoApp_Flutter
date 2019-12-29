import 'package:today_do/bloc/create_todo.dart';
import 'package:today_do/bloc/home_bloc.dart';
import 'package:today_do/bloc/todo_list_bloc.dart';

class AppBLoC {
  ToDoListBLoC toDoListBLoC;
  CreateToDoBLoC createToDoBLoC;
  HomeBLoC homeBLoC;

  AppBLoC(this.toDoListBLoC, this.createToDoBLoC, this.homeBLoC);

  void dispose() {
    toDoListBLoC.dispose();
    createToDoBLoC.dispose();
    homeBLoC.dispose();
  }
}