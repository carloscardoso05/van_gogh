import 'package:flutter/material.dart';
import 'package:van_gogh/controllers/houses_controller.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/services/auth_service.dart';

class AdminView extends StatelessWidget {
  AdminView({super.key});
  final List<House> houses = getIt<HousesController>().getHouses();

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Text(getIt<AuthService>().auth?.user?.id ?? ""),
    );
  }
}
