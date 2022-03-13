import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';
  final auth = FirebaseAuth.instance;
  // FirebaseUser no se utiliza mas, se utiliza UserCredential
  late UserCredential currentUser;

  void getCurrentUser() async {
    var user = await auth.currentUser;
    if (user != null) {
      currentUser = user as UserCredential;
      print(currentUser.user?.email);
    }
  }

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
    );
  }
}
