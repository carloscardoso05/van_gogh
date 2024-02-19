import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/entities/resident.dart';
import 'package:van_gogh/helpers/payment_helpers.dart';
import 'package:van_gogh/repositories/houses_repository.dart';

enum Status { loading, updating, success, error }

class HousesController {
  bool isAscending = false;
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
    sort((house) => getMostDelayedPaymentOrLatest(house.payments).state.index);
    status.value = Status.success;
  }

  House getHouseById(int id) {
    return _houses.firstWhere((house) => house.id == id);
  }

  House? getHouseByHolder(Holder holder) {
    return _houses.firstWhere((house) => house.holder?.id == holder.id);
  }

  List<House> getHouses() {
    return UnmodifiableListView(_houses);
  }

  removeHouse(House house) {
    _houses.remove(house);
  }

  void sort(Comparable Function(House) getProperty, {bool ascending = false}) {
    status.value = Status.updating;
    isAscending = ascending;
    if (!isAscending) {
      _houses.sort((a, b) => getProperty(a).compareTo(getProperty(b)));
    } else {
      _houses.sort((a, b) => getProperty(b).compareTo(getProperty(a)));
    }
    status.value = Status.success;
  }
}
