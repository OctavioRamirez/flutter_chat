import 'package:flutter/material.dart';
import 'package:flutter_chat/src/Widgets/app_button.dart';
import 'package:flutter_chat/src/Widgets/app_icon.dart';

class welcomeScreen extends StatefulWidget {
  static String routeName = '';
  welcomeScreen({Key? key}) : super(key: key);

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppIcon(),
                SizedBox(
                  height: 48.0,
                ),
                AppButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    name: 'Log in'),
                AppButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, '');
                    },
                    name: 'Registrarse')
              ],
            )));
  }
}
