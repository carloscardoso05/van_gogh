import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/repositories/holders_repository.dart';
import 'package:van_gogh/repositories/payments_repository.dart';
import 'package:van_gogh/supabase.dart';
import 'package:van_gogh/transformers/house_transformer.dart';

abstract class HousesRepository {
  PaymentsRepository paymentsRepository;
  HoldersRepository holdersRepository;
  HousesRepository(
      {required this.holdersRepository, required this.paymentsRepository});
  List<House> houses = [];
  Future<List<House>> getAll();
}

class LocalHousesRepository extends HousesRepository {
  LocalHousesRepository(
      {required super.holdersRepository, required super.paymentsRepository});

  @override
  Future<List<House>> getAll() async {
    final housesData = await supabase
        .from('houses')
        .select('*, holder:holder_id(*), payments(*)');
    final payments = await paymentsRepository.getAll();
    final holders = await holdersRepository.getAll();
    final houses = housesData.map((houseJson) {
      return HouseTranformer.fromJson(
        houseJson,
        holders.firstWhere((element) => element.id == houseJson['holder_id']),
        payments
            .where((element) => element.houseId == houseJson['id'])
            .toList(),
      );
    }).toList();
    return houses;
  }
}
