import 'package:flutter/material.dart';
import 'package:flutter_chat/src/Widgets/app_button.dart';
import 'package:flutter_chat/src/Widgets/app_icon.dart';
import 'package:flutter_chat/src/Widgets/app_textfield.dart';
import 'package:flutter_chat/src/mixins/validation_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/src/services/authentication.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routerName = '/registration';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with ValidationMixins {
  late String _email;
  late String _password;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNodeEmail.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
          AppTextfield(
            inputText: "Ingresar Email",
            validator: validateEmail,
            obscureText: false,
            onChanged: (value) {
              _email = value;
            },
            controller: _emailController,
            focusNode: _focusNodeEmail,
          ),
          SizedBox(height: 8.0),
          AppTextfield(
            inputText: "Ingresar contraseña",
            validator: validatePassword,
            obscureText: true,
            onChanged: (value) {
              _password = value;
            },
            controller: _passwordController,
          ),
          SizedBox(
            height: 48.0,
          ),
          AppButton(
            color: Colors.blueAccent,
            onPressed: () async {
              var newUser = await Authenticator()
                  .createUser(email: _email, password: _password);
              if (newUser != null) {
                Navigator.pushNamed(context, '/chat');
                _emailController.text = "";
                _passwordController.text = "";
                FocusScope.of(context).requestFocus(_focusNodeEmail);
              }
            },
            name: "Registrarse",
          )
        ],
      ),
    ));
  }
}
