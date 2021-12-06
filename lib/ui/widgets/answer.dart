import 'package:flutter/material.dart';

class AnswerChild extends StatefulWidget {
  final Color color;
  final String data;
  final double txtsize;
  const AnswerChild(
      {Key? key, required this.color, required this.data, this.txtsize = 25.0})
      : super(key: key);
  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<AnswerChild> {
  final txtsize = 10;
  @override
  Widget build(BuildContext context) {
    return Card(
        color: widget.color,
        margin: const EdgeInsets.all(2),
        shadowColor: Colors.yellow,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            widget.data,
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                fontFamily: "tahoma"),
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        ));
  }
}
