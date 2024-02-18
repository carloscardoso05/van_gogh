import 'dart:convert';

import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/entities/payment.dart';
import 'package:van_gogh/entities/resident.dart';

class HouseTranformer {
  static String toJson(House payment) => json.encode(toMap(payment));

  // static House fromJson(String source) => fromMap(json.decode(source));
  static House fromJson(
          Map<String, dynamic> source, Holder? holder, List<Payment> payments) =>
      fromMap(
        source,
        holder,
        payments,
      );

  static Map<String, dynamic> toMap(House house) {
    return {
      'block': house.block,
      'number': house.number,
      'holder_id': house.holder?.id ?? '',
    };
  }

  static House fromMap(
      Map<String, dynamic> map, Holder? holder, List<Payment> payments) {
    return House(
      id: map['id'],
      block: map['block'],
      number: map['number'],
      holder: holder,
      payments: payments,
    );
  }
}
