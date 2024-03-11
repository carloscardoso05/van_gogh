import 'package:intl/intl.dart';
import 'package:van_gogh/entities/payment.dart';

// 20/10/2030
final DateFormat shortDateFormat = DateFormat.yMd();
// 20 de outubro de 2030
final DateFormat extendedDateFormat = DateFormat.yMMMMd();
// 20 de outubro
final DateFormat dateFormat = DateFormat.MMMMd();
// terça feira
final DateFormat weekDayDateFormat = DateFormat.EEEE();
// terça, 10 de outubro
final DateFormat extendedWeekDayDateFormat = DateFormat.MMMMEEEEd();
// outubro
final DateFormat monthDateFormat = DateFormat.LLLL();
final NumberFormat numberFormat = NumberFormat('R\$ #,##0.00');
String getMonthPtBr(int i) {
  if (i < 1 || i > 12) {
    throw Exception('Invalid month ($i). Valid range: 1..12');
  }
  return const [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ][i - 1];
}

String getPaymentStatePtBr(PaymentState state) {
  return switch (state) {
    PaymentState.late => "Atrasado",
    PaymentState.pending => "Pendente",
    PaymentState.pendingVerification => "Verificação pendente",
    PaymentState.paid => "Pago"
  };
}
