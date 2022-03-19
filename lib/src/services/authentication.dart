import 'package:firebase_auth/firebase_auth.dart';

class Authenticator {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> createUser(
      {String email = "", String password = ""}) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return await _auth.currentUser;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential> logInUser(
      {String email = "", String password = ""}) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logOutUser() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
