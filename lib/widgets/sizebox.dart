import 'package:flutter/material.dart';

class SizeBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SizeBoxState();
  }
}

class _SizeBoxState extends State<SizeBox> {
  double size = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("sizebox")),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular((size!) / 2))),
            width: size,
            height: size,
          ),
        ),
        floatingActionButton: TextButton(
            onPressed: () {
              setState(() {
                size = size + 10.0;
              });
            },
            child: const Text('变大')));
  }
}
