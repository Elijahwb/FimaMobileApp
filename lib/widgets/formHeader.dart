import 'package:flutter/material.dart';

class FormHeader extends StatefulWidget {
  final String headerText;
  final Color textColor;

  FormHeader({this.textColor, this.headerText});
  @override
  _FormHeaderState createState() => _FormHeaderState();
}

class _FormHeaderState extends State<FormHeader> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.headerText,
      style: TextStyle(
        color: widget.textColor,
        fontWeight: FontWeight.w400,
        fontSize: 22.0,
      ),
    );
  }
}
