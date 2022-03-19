import 'package:flutter/material.dart';
import 'package:flutter_chat/src/Widgets/app_button.dart';
import 'package:flutter_chat/src/Widgets/app_icon.dart';
import 'package:flutter_chat/src/Widgets/app_textfield.dart';
import 'package:flutter_chat/src/services/authentication.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;
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
                AppTextfield(
                    inputText: "Ingresar Email",
                    obscureText: false,
                    onChanged: (value) {
                      _email = value;
                    }),
                SizedBox(
                  height: 8.0,
                ),
                AppTextfield(
                    inputText: "Ingresar Contraseña",
                    obscureText: true,
                    onChanged: (value) {
                      _password = value;
                    }),
                SizedBox(
                  height: 23.0,
                ),
                AppButton(
                    color: Colors.blueAccent,
                    onPressed: () async {
                      var user = await Authenticator()
                          .logInUser(email: _email, password: _password);
                      if (user != null) {
                        Navigator.pushNamed(context, '/chat');
                      }
                    },
                    name: 'Log in')
              ],
            )));
  }
}
