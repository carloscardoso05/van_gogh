import 'package:flutter/material.dart';
import 'package:van_gogh/entities/payment.dart';

Icon getPaymentIcon(PaymentState? state) {
  if (state == PaymentState.late) {
    return const Icon(Icons.timer_off_outlined, color: Colors.red);
  }
  if (state == PaymentState.paid || state == null) {
    return const Icon(Icons.thumb_up_outlined, color: Colors.green);
  }
  if (state == PaymentState.pending) {
    return const Icon(Icons.timer_outlined, color: Colors.amber);
  }
  //Avaliação pendente
  return const Icon(Icons.document_scanner_outlined, color: Colors.purple);
}
