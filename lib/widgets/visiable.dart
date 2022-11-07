import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class VisiableDemo extends StatefulWidget {
  const VisiableDemo({super.key});

  @override
  State<VisiableDemo> createState() => _VisiableDemoState();
}

class _VisiableDemoState extends State<VisiableDemo> {
  bool display = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("visiable demo"),
        actions: [
          Switch(
              value: display,
              onChanged: (bool value) {
                setState(() {
                  display = value;
                });
              })
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.red,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
          Positioned(
            left: 300,
            top: 300,
            child: Visibility(
                visible: display,
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.green,
                )),
          )
        ],
      ),
    );
  }
}
