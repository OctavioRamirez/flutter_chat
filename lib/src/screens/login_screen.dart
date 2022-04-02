import 'package:flutter/material.dart';
import 'package:flutter_chat/src/Widgets/app_button.dart';
import 'package:flutter_chat/src/Widgets/app_error_message.dart';
import 'package:flutter_chat/src/Widgets/app_icon.dart';
import 'package:flutter_chat/src/Widgets/app_textfield.dart';
import 'package:flutter_chat/src/mixins/validation_mixin.dart';
import 'package:flutter_chat/src/model/authentication_request.dart';
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

class _LoginScreenState extends State<LoginScreen> with ValidationMixins {
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _errorMessage = '';

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

  // funcion temporal para mostrar el error
  void _showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Esconder',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
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
                        SizedBox(
                          height: 8.0,
                        ),
                        _showErrorMessage(),
                        SizedBox(
                          height: 23.0,
                        ),
                        _passwordField(),
                        SizedBox(
                          height: 23.0,
                        ),
                        _submitField()
                      ],
                    )))));
  }

  Widget _emailField() {
    return AppTextfield(
      inputText: "Ingresar Email",
      obscureText: false,
      onChanged: (value) {},
      controller: _emailFieldController,
      validator: validateEmail,
      focusNode: _focusNodeEmail,
      autoValidate: true,
    );
  }

  Widget _passwordField() {
    return AppTextfield(
      focusNode: _focusNodePassword,
      inputText: "Ingresar Contraseña",
      validator: validatePassword,
      obscureText: true,
      onChanged: (value) {},
      controller: _passwordFieldController,
      autoValidate: true,
    );
  }

  Widget _submitField() {
    return AppButton(
        color: Colors.blueAccent,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            toggleSpinner(true);
            var authRequest = await Authenticator().logInUser(
                email: _emailFieldController.text,
                password: _passwordFieldController.text);

            if (authRequest.success) {
              Navigator.pushNamed(context, '/chat');
              // _emailFieldController.text = '';
              _passwordFieldController.text = '';

              if (_emailFieldController.text.isNotEmpty) {
                FocusScope.of(context).requestFocus(_focusNodePassword);
              } else {
                FocusScope.of(context).requestFocus(_focusNodeEmail);
              }
            } else {
              toggleSpinner(false);
              setState(() {
                _errorMessage = authRequest.errorMessage;
              });
            }

            toggleSpinner(false);
          }
        },
        name: 'Log in');
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return ErrorMessage(errorMessage: _errorMessage);
    } else {
      return Container(
        height: 0.0,
      );
    }
  }
}
