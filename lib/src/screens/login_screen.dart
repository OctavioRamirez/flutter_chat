import 'package:flutter/material.dart';
import 'package:flutter_chat/src/Widgets/app_button.dart';
import 'package:flutter_chat/src/Widgets/app_icon.dart';
import 'package:flutter_chat/src/Widgets/app_textfield.dart';
import 'package:flutter_chat/src/services/authentication.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

/// This library does not support sound null safety methods
/// thus it does not compile well on flutter 2.10+
/// but we can bypass this running it like this
/// flutter run --no-sound-null-safety

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
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
  }

  void toggleSpinner(bool status) {
    setState(() {
      _isLoading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Container(
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
                    toggleSpinner(true);
                    var user = await Authenticator()
                        .logInUser(email: _email, password: _password);
                    if (user != null) {
                      Navigator.pushNamed(context, '/chat');
                      // _emailFieldController.text = '';
                      _passwordFieldController.text = '';

                      if (_emailFieldController.text.isNotEmpty) {
                        FocusScope.of(context).requestFocus(_focusNodePassword);
                      } else {
                        FocusScope.of(context).requestFocus(_focusNodeEmail);
                      }
                      toggleSpinner(false);
                    }
                  },
                  name: 'Log in')
            ],
          )),
    ));
  }
}
