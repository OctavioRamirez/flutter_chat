class ValidationMixins {
  String? validateEmail(String? value) {
    if (value != null && !value.contains('@')) return "email invalido";
    return null;
  }

  String? validatePassword(String? value) {
    if (value != null && !(value.length > 5)) return "contraseña invalida";
    return null;
  }
}
