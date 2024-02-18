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
  bool isAdmin = true;
  User get grantedUser => auth!.user!;

  AuthService() {
    recoverSession();
  }

  recoverSession() async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      auth = await supabase.auth.recoverSession(jsonEncode(session));
      isAuthenticated = true;
      notifyListeners();
    }
  }

  login({required String email, required String password}) async {
    final authResponse = await supabase.auth
        .signInWithPassword(email: email, password: password);
    isAuthenticated = true;
    auth = authResponse;
    holder = Holder(
      id: auth!.user!.id,
      name: auth!.user!.userMetadata!['name'],
      email: auth!.user!.email!,
      phone: auth!.user!.userMetadata!['phone'],
    );
    notifyListeners();
  }

  register({
    required String email,
    required String password,
    required String name,
    String phone = "",
  }) async {
    await supabase.auth.signUp(
        email: email, password: password, data: {'name': name, 'phone': phone});
    await login(email: email, password: password);
    holder = Holder(
      id: auth!.user!.id,
      name: name,
      email: email,
      phone: phone,
    );
    await getIt<HoldersRepository>().addHolder(holder!);
  }

  logOut() async {
    await supabase.auth.signOut();
    isAuthenticated = false;
    auth = null;
    notifyListeners();
  }
}
