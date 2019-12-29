import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:today_do/bloc/create_todo.dart';

class DecidePriorityComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var createToDoBLoC = Provider.of<CreateToDoBLoC>(context);

    return StreamBuilder<double>(
      stream: createToDoBLoC.sliderValueStream,
      initialData: 0.5,
      builder: (context, snapShot) {
        if (snapShot.hasData)
          return Column(
            children: <Widget>[
              Text(
                "優先度",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    iconSize: 40,
                    onPressed: () {
                      createToDoBLoC.sliderActionSink.add(
                          snapShot.data - CreateToDoBLoC.sliderUnitConstant);
                    },
                  ),
                  Slider(
                    value: snapShot.data,
                    onChanged: (value) {
                      createToDoBLoC.sliderActionSink.add(value);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_right),
                    iconSize: 40,
                    onPressed: () {
                      createToDoBLoC.sliderActionSink.add(
                          snapShot.data + CreateToDoBLoC.sliderUnitConstant);
                    },
                  ),
                ],
              ),
            ],
          );

        return Container();
      },
    );
  }
}
