import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/src/model/authentication_request.dart';

class Authenticator {
  final _auth = FirebaseAuth.instance;

  Future<AuthenticationRequest> createUser(
      {String email = "", String password = ""}) async {
    AuthenticationRequest authRequest = AuthenticationRequest();
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((_) => authRequest.success = true);
    } on FirebaseAuthException catch (e) {
      _mapErrorMessage(authRequest, e.code);
    }
    return authRequest;
  }

  Future<User?> getCurrentUser() async {
    try {
      return await _auth.currentUser;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<AuthenticationRequest> logInUser(
      {String email = "", String password = ""}) async {
    AuthenticationRequest authRequest = AuthenticationRequest();
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((_) => authRequest.success = true);
    } on FirebaseAuthException catch (e) {
      _mapErrorMessage(authRequest, e.code);
    }
    return authRequest;
  }

  Future<void> logOutUser() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  void _mapErrorMessage(AuthenticationRequest authRequest, String code) {
    switch (code) {
      case 'invalid-email':
        authRequest.errorMessage = 'Correo invalido';
        break;
      case 'user-not-found':
        authRequest.errorMessage = 'Correo no encontrado';
        break;
      case 'email-already-in-use':
        authRequest.errorMessage = 'Correo ya utilizado';
        break;
      case 'wrong-password':
        authRequest.errorMessage = 'Contraseña invalida';
        break;
      default:
        authRequest.errorMessage = code;
    }
  }
}
