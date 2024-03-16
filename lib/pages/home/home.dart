import 'package:flutter/material.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/pages/home/admin_view/admin_view.dart';
import 'package:van_gogh/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casas'),
        actions: [
          ElevatedButton(
            onPressed: getIt<AuthService>().logOut,
            child: const Text("Sair"),
          )
        ],
      ),
      body: const Center(
        child: AdminView(),
      ),
    );
  }
}
