import 'package:flutter/material.dart';

class ValidationMixins {
  String? validateEmail(String value) {
    if (!value.contains('@')) return "email invalido";
    return null;
  }

  String? validatePassword(String value) {
    if (!value.contains('@')) return "contraseña invalida";
    return null;
  }
}
