import 'package:flutter/material.dart';
import 'package:flutter_chat/src/Widgets/app_button.dart';
import 'package:flutter_chat/src/Widgets/app_icon.dart';
import 'package:flutter_chat/src/Widgets/app_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);
  static const String routerName = '/registration';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppIcon(),
          SizedBox(
            height: 48.0,
          ),
          AppTextfield(inputText: "Ingresar Email"),
          SizedBox(height: 8.0),
          AppTextfield(inputText: "Ingresar contraseña"),
          SizedBox(
            height: 48.0,
          ),
          AppButton(
              color: Colors.blueAccent, onPressed: () {}, name: "Registrarse")
        ],
      ),
    ));
  }
}
