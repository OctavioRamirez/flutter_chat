import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageServices {
  final _fireStore = FirebaseFirestore.instance;
  void save(
      {required String CollectionName,
      required Map<String, dynamic> collectionValues}) {
    _fireStore.collection(CollectionName).add(collectionValues);
  }

  getMessage() async {
    return await _fireStore
        .collection('messages')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['message']);
      });
    });
  }

  Stream<QuerySnapshot> getMessageStream() {
    return _fireStore.collection("messages").snapshots();
  }
}
