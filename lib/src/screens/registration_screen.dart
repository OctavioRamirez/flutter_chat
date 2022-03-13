import 'package:flutter/material.dart';
import 'package:flutter_chat/src/Widgets/app_button.dart';
import 'package:flutter_chat/src/Widgets/app_icon.dart';
import 'package:flutter_chat/src/Widgets/app_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routerName = '/registration';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final auth = FirebaseAuth.instance;
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
          SizedBox(height: 8.0),
          AppTextfield(
              inputText: "Ingresar contraseña",
              obscureText: true,
              onChanged: (value) {
                _password = value;
              }),
          SizedBox(
            height: 48.0,
          ),
          AppButton(
            color: Colors.blueAccent,
            onPressed: () async {
              try {
                var newUser = await auth.createUserWithEmailAndPassword(
                    email: _email, password: _password);
                if (newUser != null) {
                  Navigator.pushNamed(context, '/chat');
                }
              } catch (e) {
                print(e);
              }
            },
            name: "Registrarse",
          )
        ],
      ),
    ));
  }
}
