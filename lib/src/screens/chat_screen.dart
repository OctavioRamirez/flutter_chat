import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/src/services/authentication.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    currentUser = await Authenticator().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Screen'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.power_settings_new),
          onPressed: () async {
            await Authenticator().logOutUser();
            Navigator.pop(context);
          },
        )
      ]),
    );
  }
}
