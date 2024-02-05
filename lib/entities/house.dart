import 'package:van_gogh/entities/resident.dart';
import 'package:van_gogh/entities/payment.dart';

class House {
  final int id;
  final int block;
  final int number;
  Holder holder;
  List<Payment> payments;
  String get houseCode => '$block$number';

  House({
    required this.id,
    required this.block,
    required this.number,
    required this.holder,
    required this.payments,
  });
}
