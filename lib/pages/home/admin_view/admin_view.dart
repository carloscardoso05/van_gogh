import 'package:flutter/material.dart';
import 'package:van_gogh/controllers/houses_controller.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/pages/home/admin_view/houses_list.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final controller = getIt<HousesController>();
  get houses => controller.getHouses();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ValueListenableBuilder<Status>(
        valueListenable: controller.status,
        builder: (context, value, child) {
          if (value == Status.success) {
            return HousesList(houses: houses);
          }
          return const AspectRatio(
            aspectRatio: 1,
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
