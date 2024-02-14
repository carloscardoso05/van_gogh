import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:van_gogh/supabase.dart';

class AuthService extends ChangeNotifier {
  AuthResponse? auth;
  bool isAuthenticated = false;
  bool isAdmin = false;

  login({required String email, required String password}) async {
    final authResponse = await supabase.auth
        .signInWithPassword(email: email, password: password);
    isAuthenticated = true;
    auth = authResponse;
    notifyListeners();
  }

  register({required String email, required String password}) async {
    await supabase.auth.signUp(email: email, password: password);
    await login(email: email, password: password);
  }

  logOut() async {
    await supabase.auth.signOut();
    isAuthenticated = false;
    auth = null;
    notifyListeners();
  }
}
