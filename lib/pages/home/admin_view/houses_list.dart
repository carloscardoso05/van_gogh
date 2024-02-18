import 'package:flutter/material.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/pages/home/admin_view/house_card.dart';

class HousesList extends StatelessWidget {
  const HousesList({super.key, required this.houses});
  final List<House> houses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: houses.length,
      itemBuilder: (context, index) => HouseCard(house: houses[index]),
    );
  }
}
