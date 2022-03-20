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
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
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
                  obscureText: false,
                  onChanged: (value) {
                    _email = value;
                  },
                  controller: _emailFieldController,
                  focusNode: _focusNodeEmail,
                ),
                SizedBox(
                  height: 8.0,
                ),
                AppTextfield(
                  focusNode: _focusNodePassword,
                  inputText: "Ingresar Contraseña",
                  obscureText: true,
                  onChanged: (value) {
                    _password = value;
                  },
                  controller: _passwordFieldController,
                ),
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
                        // _emailFieldController.text = '';
                        _passwordFieldController.text = '';

                        if (_emailFieldController.text.isNotEmpty) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodePassword);
                        } else {
                          FocusScope.of(context).requestFocus(_focusNodeEmail);
                        }
                      }
                    },
                    name: 'Log in')
              ],
            )));
  }
}
