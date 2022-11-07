import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditAbleDemo extends StatefulWidget {
  const EditAbleDemo({super.key});

  @override
  State<EditAbleDemo> createState() => _EditAbleDemoState();
}

class _EditAbleDemoState extends State<EditAbleDemo> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Container(
      child: EditableText(
        selectionColor: Colors.blue,
        maxLines: 100,
        backgroundCursorColor: Colors.white,
        cursorColor: Colors.black,
        controller: controller,
        focusNode: FocusNode(),
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
