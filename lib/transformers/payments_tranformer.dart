import 'dart:convert';

import 'package:van_gogh/entities/payment.dart';

class PaymentTranformer {
  static String toJson(Payment payment) => json.encode(toMap(payment));

  // static Payment fromJson(String source) => fromMap(json.decode(source));
  static Payment fromJson(Map<String, dynamic> source) => fromMap(source);

  static Map<String, dynamic> toMap(Payment payment) {
    return {
      'value': payment.value,
      'house_id': payment.houseId,
      'paid_value': payment.paidValue,
      'due_date': payment.dueDate.toIso8601String(),
      'paid_date': payment.paidDate?.toIso8601String() ?? '',
      'file_path': payment.filePath,
    };
  }

  static Payment fromMap(Map<String, dynamic> map) {
    final payment = Payment(
      id: map['id'],
      houseId: map['house_id'],
      value: map['value'],
      paidValue: map['paid_value'],
      dueDate: DateTime.parse(map['due_date']),
      paidDate: DateTime.tryParse(map['paid_date'] ?? ''),
      filePath: map['file_path'] ?? '',
    );
    return payment;
  }
}
