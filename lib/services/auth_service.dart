import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:van_gogh/entities/resident.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/repositories/holders_repository.dart';
import 'package:van_gogh/supabase.dart';

class AuthService extends ChangeNotifier {
  AuthResponse? auth;
  Holder? holder;
  bool isAuthenticated = false;
  bool isAdmin = false;
  User get grantedUser => auth!.user!;

  AuthService() {
    recoverSession();
  }

  recoverSession() async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      auth = await supabase.auth.recoverSession(jsonEncode(session));
      await loadUserData();
      isAuthenticated = true;
      notifyListeners();
    }
  }

  login({required String email, required String password}) async {
    final authResponse = await supabase.auth
        .signInWithPassword(email: email, password: password);
    isAuthenticated = true;
    auth = authResponse;
    await loadUserData();
    notifyListeners();
  }

  loadUserData() async {
    holder = await getIt<HoldersRepository>().getByEmail(auth!.user!.email!);
    holder!.name = auth!.user!.userMetadata!['name'];
    holder!.phone = auth!.user!.userMetadata!['phone'];
    isAdmin = holder!.isAdmin;
  }

  register({
    required String email,
    required String password,
    required String name,
    String phone = "",
  }) async {
    await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name, 'phone': phone, 'is_admin': false});
    await login(email: email, password: password);
    await getIt<HoldersRepository>().addHolder(holder!);
  }

  logOut() async {
    await supabase.auth.signOut();
    isAuthenticated = false;
    auth = null;
    notifyListeners();
  }
}
