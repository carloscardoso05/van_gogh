import 'package:flutter/material.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/repositories/houses_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.isAdmin});
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getIt<HousesRepository>().getAll(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Text(snapshot.data.toString());
          }

          return const Text('Carregando');
        },
      ),
    );
  }
}
