enum PaymentState {
  late,
  pending,
  pendingVerification,
  paid,
  ;

  bool operator >(PaymentState other) => index > other.index;
  bool operator <(PaymentState other) => index < other.index;
  bool operator >=(PaymentState other) => index >= other.index;
  bool operator <=(PaymentState other) => index <= other.index;
}

class Payment {
  final int id;
  final int houseId;
  final DateTime dueDate;
  DateTime? paidDate;
  String filePath;
  final double value;
  final double paidValue;
  PaymentState get state {
    if (paidDate != null) {
      return PaymentState.paid;
    }
    if (filePath.isNotEmpty) {
      return PaymentState.pendingVerification;
    }
    if (DateTime.now().compareTo(dueDate) > 0) {
      return PaymentState.late;
    }
    return PaymentState.pending;
  }


  Payment({
    required this.id,
    required this.houseId,
    required this.dueDate,
    required this.value,
    this.paidValue = 0,
    this.filePath = "",
    this.paidDate,
  });
}
