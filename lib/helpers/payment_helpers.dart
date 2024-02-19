import 'package:flutter/material.dart';
import 'package:van_gogh/entities/payment.dart';

Payment? getMostDelayedPayment(List<Payment> payments) {
  /// Retorna o pagamento atrasado mais antigo, se houver
  Payment? latest;
  for (final payment in payments) {
    if (latest == null &&
        [PaymentState.late, PaymentState.pending].contains(payment.state)) {
      latest = payment;
      continue;
    }
    if (latest != null && latest.dueDate.isAfter(payment.dueDate)) {
      latest = payment;
    }
  }
  return latest;
}

Payment getMostDelayedPaymentOrLatest(List<Payment> payments) {
  /// Retorna o pagamento atrasado mais antigo, se houver
  Payment? latest = getMostDelayedPayment(payments);
  return latest ?? payments.last;
}

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
