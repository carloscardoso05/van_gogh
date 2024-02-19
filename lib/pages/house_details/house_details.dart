import 'package:flutter/material.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/transformers/house_transformer.dart';

class HouseDetails extends StatelessWidget {
  const HouseDetails({super.key, required this.house});
  final House house;

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Text(HouseTranformer.toJson(house).toString()),
    );
  }
}
