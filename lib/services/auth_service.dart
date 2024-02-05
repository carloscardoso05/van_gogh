import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool isAuthenticated = true;
  bool isAdmin = false;

  login() {
    isAuthenticated = true;
    notifyListeners();
  }

  logOut() {
    isAuthenticated = false;
    notifyListeners();
  }
}
