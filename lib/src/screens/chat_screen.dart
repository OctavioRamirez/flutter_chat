import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/src/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/src/services/message_services.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _messages = _firestore.collection('messages');
  late User? currentUser;
  InputDecoration _messageTextFieldDecoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      hintText: 'puto el que escribe',
      border: InputBorder.none);
  BoxDecoration _messageContainerDecoration = BoxDecoration(
      border: Border(top: BorderSide(color: Colors.lightBlue, width: 2.0)));

  TextStyle _sendButtonStyle = TextStyle(
      color: Colors.lightBlueAccent,
      fontWeight: FontWeight.bold,
      fontSize: 18.0);

  TextEditingController _messageController = TextEditingController();

  InputDecoration _messageTextFieldDecotarion = InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      hintText: 'Ingrese su mensaje aqui...',
      border: InputBorder.none);

  BoxDecoration _messageContainterDecoration = BoxDecoration(
      border:
          Border(top: BorderSide(color: Colors.lightBlueAccent, width: 2.0)));

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    currentUser = await Authenticator().getCurrentUser();
  }

  void _getMessage() async {
    final messages = await MessageServices().getMessage();
    for (var message in messages.doc) {
      print(message.data);
    }
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: _messageContainerDecoration,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    decoration: _messageTextFieldDecoration,
                    controller: _messageController,
                  )),
                  TextButton(
                    child: Text(
                      "Enviar",
                      style: _sendButtonStyle,
                    ),
                    onPressed: () {
                      print(_messageController.value);
                      _messages.add({
                        'value': _messageController.text,
                        'sender': currentUser?.email
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
