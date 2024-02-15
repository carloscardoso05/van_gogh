import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/entities/resident.dart';
import 'package:van_gogh/repositories/houses_repository.dart';

enum Status { loading, updating, success, error }

class HousesController {
  List<House> _houses = [];
  final HousesRepository _housesRepository;
  ValueNotifier<Status> status = ValueNotifier(Status.loading);

  HousesController({required HousesRepository housesRepository})
      : _housesRepository = housesRepository {
    loadHouses();
  }

  loadHouses() async {
    status.value = Status.loading;
    _houses = await _housesRepository.getAll();
    status.value = Status.success;
  }

  House getHouseById(int id) {
    return _houses.firstWhere((house) => house.id == id);
  }

  House getHouseByHolder(Holder holder) {
    return _houses.firstWhere((house) => house.holder.id == holder.id);
  }

  List<House> getHouses() {
    return UnmodifiableListView(_houses);
  }

  removeHouse(House house) {
    _houses.remove(house);
  }
}
