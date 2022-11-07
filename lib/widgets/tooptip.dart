import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learn_flutter/widgets/sizebox.dart';

class TipDemo extends StatefulWidget {
  const TipDemo({super.key});

  @override
  State<TipDemo> createState() => _TipDemoState();
}

class _TipDemoState extends State<TipDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Hover(
              hoverChild: Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.green,
              )),
          const Text("1111111")
        ],
      ),
    );
  }
}

class Hover extends StatefulWidget {
  Widget child;
  Widget hoverChild;

  Hover({required this.child, required this.hoverChild, super.key});

  @override
  State<Hover> createState() => _HoverState();
}

class _HoverState extends State<Hover> {
  bool hovering = false;
  late BuildContext ctx;

  show() async {
    OverlayState? state = Overlay.of(context);
    if (state == null) {
      print("return");
      return;
    }
    Size? size = context.size;
    if (size == null) {
      print("null");
    }
    OverlayEntry entry = OverlayEntry(builder: (context) {
      return Positioned(top: size?.height ?? 10, child: widget.hoverChild);
    });

    state.insert(entry);
    Future.delayed(Duration(seconds: 2)).then((value) => entry.remove());
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Container(
      child: MouseRegion(
        child: widget.child,
        onHover: (v) {
          show();
        },
        onExit: (PointerExitEvent event) {},
      ),
    );
  }
}
