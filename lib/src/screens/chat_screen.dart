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
    _getMessage();
  }

  void getCurrentUser() async {
    currentUser = await Authenticator().getCurrentUser();
  }

  void _getMessage() async {
    await for (var snapshot in MessageServices().getMessageStream()) {
      for (var message in snapshot.docs) {
        print(message.data);
      }
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
            StreamBuilder(
                stream: MessageServices().getMessageStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Flexible(
                        child: ListView(
                      children: _getChatItems(snapshot.data.docs),
                    ));
                  }
                }),
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
                      _messageController
                          .clear(); //limpia la caja despues de enviar
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

  List<ChatItem> _getChatItems(dynamic messages) {
    List<ChatItem> chatItems = [];
    for (var message in messages) {
      final messageValue = message.data["value"];
      final messageSender = message.data["sender"];
      chatItems.add(ChatItem(
        message: messageValue,
        sender: messageSender,
        isLoggedInUser: messageSender == loggedInUser.email,
      ));
    }
    return chatItems;
  }
}

class ChatItem extends StatelessWidget {
  late final String sender;
  late final String message;
  late final bool isLoggedInUser;

  ChatItem(
      {required this.sender,
      required this.message,
      required this.isLoggedInUser});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        Material(
            borderRadius: BorderRadius.circular(30.0),
            child: Text(
              sender,
              style: TextStyle(fontSize: 15.0, color: Colors.black54),
            )),
        Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isLoggedInUser ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 16.0,
                    color: isLoggedInUser ? Colors.white : Colors.black54),
              ),
            )),
      ]),
    );
  }
}
