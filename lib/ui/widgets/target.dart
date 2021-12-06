import 'package:flutter/material.dart';
import "package:dotted_border/dotted_border.dart";

class Target extends StatefulWidget {
  bool isDropped;
  final Function(String) onAccept;
  final Function(String?) onLeave;
  final Function(String?) onWillAccept;
  final Widget child;
  var color;
  Target(
      {Key? key,
      required this.child,
      required this.isDropped,
      required this.color,
      required this.onAccept,
      required this.onLeave,
      required this.onWillAccept})
      : super(key: key);

  @override
  _TargetState createState() => _TargetState();
}

class _TargetState extends State<Target> {
  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          padding: const EdgeInsets.all(6),
          color: Colors.white,
          strokeWidth: 2,
          dashPattern: const [8],
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(color: Colors.pink),
              color: widget.isDropped ? Colors.redAccent : null,
              child: widget.child,
            ),
          ),
        );
      },
      onAccept: (data) {
        widget.onAccept(data);
      },
      onWillAccept: (data) => widget.onWillAccept(data),
      onLeave: (data) => widget.onLeave(data),
    );
  }
}
