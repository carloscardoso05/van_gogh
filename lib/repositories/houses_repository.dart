import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/repositories/holders_repository.dart';
import 'package:van_gogh/repositories/payments_repository.dart';
import 'package:van_gogh/supabase.dart';
import 'package:van_gogh/transformers/house_transformer.dart';

abstract class HousesRepository {
  final PaymentsRepository _paymentsRepository;
  final HoldersRepository _holdersRepository;
  HousesRepository(
      {required HoldersRepository holdersRepository,
      required PaymentsRepository paymentsRepository})
      : _holdersRepository = holdersRepository,
        _paymentsRepository = paymentsRepository;
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
    final payments = await _paymentsRepository.getAll();
    final holders = await _holdersRepository.getAll();
    final houses = housesData.map((houseJson) {
      return HouseTranformer.fromJson(
        houseJson,
        holders
            .where((element) => element.id == houseJson['holder_id'])
            .singleOrNull,
        payments
            .where((element) => element.houseId == houseJson['id'])
            .toList(),
      );
    }).toList();
    return houses;
  }
}
