import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/ui/home_page.dart';

import 'bloc/home_bloc.dart';
import 'ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Provider<HomeBLoC>(
            create: (_) => HomeBLoC(),
            dispose: (_, bloc) => bloc.dispose(),
            child: Scaffold(
              appBar: AppBar(
                title: Text("ToDoリスト"),
              ),
              body: HomePage(),
            )));
  }
}
