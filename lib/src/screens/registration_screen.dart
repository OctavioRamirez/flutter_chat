import 'package:flutter/material.dart';
import 'package:flutter_chat/src/Widgets/app_button.dart';
import 'package:flutter_chat/src/Widgets/app_icon.dart';
import 'package:flutter_chat/src/Widgets/app_textfield.dart';
import 'package:flutter_chat/src/mixins/validation_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/src/services/authentication.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routerName = '/registration';
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with ValidationMixins {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  bool _isLoading = false;
  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _focusNodeEmail.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
            child: Form(
                key: _formKey,
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
                        _emailField(),
                        SizedBox(height: 8.0),
                        _passwordField(),
                        SizedBox(
                          height: 48.0,
                        ),
                        _submitButton()
                      ],
                    )))));
  }

  Widget _emailField() {
    return AppTextfield(
      inputText: "Ingresar Email",
      validator: validateEmail,
      obscureText: false,
      onChanged: (value) {},
      controller: _emailController,
      focusNode: _focusNodeEmail,
      autoValidate: _autoValidate,
    );
  }

  Widget _passwordField() {
    return AppTextfield(
      inputText: "Ingresar contraseña",
      validator: validatePassword,
      obscureText: true,
      onChanged: (value) {},
      controller: _passwordController,
      autoValidate: _autoValidate,
    );
  }

  Widget _submitButton() {
    return AppButton(
      color: Colors.blueAccent,
      onPressed: () async {
        toggleSpinner(true);
        if (_formKey.currentState!.validate()) {
          var newUser = await Authenticator()
              .createUser(
                  email: _emailController.text,
                  password: _passwordController.text)
              .then((_) {
            _emailController.text = "";
            _passwordController.text = "";
            FocusScope.of(context).requestFocus(_focusNodeEmail);
            Navigator.pushNamed(context, '/chat');
          }).catchError((e) {
            print(e);
            setState(() => _autoValidate = true);
          });
        }
        toggleSpinner(false);
      },
      name: "Registrarse",
    );
  }
}
