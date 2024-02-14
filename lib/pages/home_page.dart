import 'package:flutter/material.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/repositories/houses_repository.dart';
import 'package:van_gogh/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.isAdmin});
  final bool isAdmin;

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
        child: FutureBuilder(
          future: getIt<HousesRepository>().getAll(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Text(snapshot.data.toString());
            }

            return const Text('Carregando');
          },
        ),
      ),
    );
  }
}
