import 'dart:convert';

import 'package:van_gogh/entities/resident.dart';

class HolderTranformer {
  static String toJson(Holder holder) => json.encode(toMap(holder));

  // static Holder fromJson(String source) => fromMap(json.decode(source));
  static Holder fromJson(Map<String, dynamic> source) => fromMap(source);

  static Map<String, dynamic> toMap(Holder holder) {
    return {
      'name': holder.name,
      'email': holder.email,
      'phone': holder.phone,
    };
  }

  static Holder fromMap(Map<String, dynamic> map) {
    return Holder(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}
