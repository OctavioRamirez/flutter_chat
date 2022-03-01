import 'package:flutter/material.dart';
import 'package:flutter_chat/src/Widgets/app_button.dart';
import 'package:flutter_chat/src/Widgets/app_icon.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextField getTextField(String inputText) {
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
                getTextField("Ingresar Email"),
                SizedBox(
                  height: 8.0,
                ),
                getTextField("Ingresar Contraseña"),
                SizedBox(
                  height: 23.0,
                ),
                AppButton(
                    color: Colors.blueAccent, onPressed: () {}, name: 'Log in')
              ],
            )));
  }
}
