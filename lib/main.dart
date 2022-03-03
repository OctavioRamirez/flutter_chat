import 'package:flutter/material.dart';
import 'package:flutter_chat/src/screens/login_screen.dart';
import 'package:flutter_chat/src/screens/registration_screen.dart';
import 'package:flutter_chat/src/screens/welcome_screen.dart';

import 'src/screens/welcome_screen.dart';

void main() {
  runApp(MaterialApp(
    home: welcomeScreen(),
    theme: ThemeData(
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black45))),
    initialRoute: welcomeScreen.routeName,
    routes: <String, WidgetBuilder>{
      LoginScreen.routeName: (BuildContext context) => LoginScreen(),
      welcomeScreen.routeName: (BuildContext context) => welcomeScreen(),
      RegistrationScreen.routerName: (BuildContext context) =>
          RegistrationScreen()
    },
  ));
}
