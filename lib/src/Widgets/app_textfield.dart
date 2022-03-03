import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  final String inputText;
  const AppTextfield({required this.inputText});

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            hintText: inputText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide:
                    BorderSide(color: Colors.lightBlueAccent, width: 2.0)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide:
                    BorderSide(color: Colors.lightBlueAccent, width: 2.0))));
  }
}
