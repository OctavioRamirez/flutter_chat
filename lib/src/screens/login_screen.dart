import 'package:flutter/material.dart';
import 'package:flutter_chat/src/Widgets/app_button.dart';
import 'package:flutter_chat/src/Widgets/app_icon.dart';
import 'package:flutter_chat/src/Widgets/app_textfield.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                SizedBox(
                  height: 8.0,
                ),
                AppTextfield(inputText: "Ingresar Contraseña"),
                SizedBox(
                  height: 23.0,
                ),
                AppButton(
                    color: Colors.blueAccent, onPressed: () {}, name: 'Log in')
              ],
            )));
  }
}
