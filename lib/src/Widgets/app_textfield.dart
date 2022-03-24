import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  final String inputText;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FormFieldValidator<String> validator;

  const AppTextfield(
      {required this.inputText,
      required this.onChanged,
      required this.obscureText,
      required this.controller,
      required this.focusNode,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      focusNode: focusNode,
      controller: controller,
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
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0))),
      onChanged: onChanged,
      obscureText: obscureText,
    );
  }
}
