import 'package:flutter/material.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/pages/home/admin_view/admin_view.dart';
import 'package:van_gogh/pages/home/holder_view.dart';
import 'package:van_gogh/services/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final bool isAdmin = getIt<AuthService>().isAdmin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: getIt<AuthService>().logOut,
            child: const Text("Sair"),
          )
        ],
      ),
      body: Center(
        child: Visibility(
          visible: isAdmin,
          replacement: const HolderView(),
          child: const AdminView(),
        ),
      ),
    );
  }
}
