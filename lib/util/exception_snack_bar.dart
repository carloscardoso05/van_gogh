import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String translateAuthException(AuthException exception) {
  switch (exception.message) {
    case "Email not confirmed":
      return "Esse email ainda não foi confirmado";
    case "Invalid login credentials":
      return "Email ou senha inválidos";
    default:
      return exception.message;
  }
}

SnackBar createAuthExceptionSnackbar(AuthException exception) {
  final message = translateAuthException(exception);
  return SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
  );
}
