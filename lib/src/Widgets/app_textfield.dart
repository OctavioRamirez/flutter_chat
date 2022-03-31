import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  final String inputText;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FormFieldValidator<String> validator;
  final bool autoValidate;

  const AppTextfield(
      {required this.inputText,
      required this.onChanged,
      required this.obscureText,
      required this.controller,
      this.focusNode,
      required this.validator,
      required this.autoValidate});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // autoValidate esta deprecado y se tiene que usar autovalidateMode
      // onUserInteraction se activa cuando se modifica algo en el input
      // always verifica siempre
      // disabled verifica nunca
      autovalidateMode: autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
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
