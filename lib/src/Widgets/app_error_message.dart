import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;
  ErrorMessage({required this.errorMessage});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      ),
    );
  }
}
