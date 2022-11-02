import 'package:flutter/material.dart';

class MySwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MySwitchState();
  }
}

class _MySwitchState extends State<MySwitch> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("switch")),
        body: Container(
            constraints: BoxConstraints.expand(),
            color: value ? Colors.red : Colors.green,
            child: Switch(
              onChanged: (bool v) {
                setState(() {
                  value = v;
                });
              },
              value: value,
            )));
  }
}
