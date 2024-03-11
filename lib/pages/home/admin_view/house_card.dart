import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/entities/payment.dart';
import 'package:van_gogh/helpers/formating.dart';
import 'package:van_gogh/helpers/payment_helpers.dart';

class HouseCard extends StatelessWidget {
  const HouseCard({super.key, required this.house});
  final House house;
  PaymentState get latestState =>
      getMostDelayedPaymentOrLatest(house.payments).state;
  @override
  Widget build(BuildContext context) {
    if (house.payments.isNotEmpty) {
      return Card(
        child: ListTile(
            title: PaymentStateText(state: latestState),
            trailing: Text(house.houseCode),
            isThreeLine: true,
            subtitle: HousePaymentDescription(house: house),
            onTap: () => context.push('/houses/${house.houseCode}')),
      );
    }
    return const CircularProgressIndicator();
  }
}

class HousePaymentDescription extends StatelessWidget {
  HousePaymentDescription({
    super.key,
    required this.house,
  }) {
    payment = getMostDelayedPaymentOrLatest(house.payments);
  }

  final House house;
  late final Payment payment;
  String get complement {
    if (payment.state == PaymentState.paid) {
      return 'Último pagamento: ${dateFormat.format(payment.paidDate!)}';
    }
    if (payment.state == PaymentState.pendingVerification) {
      return 'Verificação pendente';
    }
    return 'Vencimento: ${dateFormat.format(payment.dueDate)}'
        '\n'
        'Valor: ${numberFormat.format(payment.value)}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${house.holder ?? "Sem proprietário"}\n$complement',
    );
  }
}

class PaymentStateText extends StatelessWidget {
  const PaymentStateText({super.key, required this.state});
  final PaymentState state;

  @override
  Widget build(BuildContext context) {
    return Text(
      getPaymentStatePtBr(state),
      style: TextStyle(color: () {
        return switch (state) {
          PaymentState.paid => Colors.green,
          PaymentState.pending => Colors.orange,
          PaymentState.late => Colors.red,
          PaymentState.pendingVerification => Colors.purple,
        };
      }()),
    );
  }
}

// Antigo HouseCard
// class HouseCard extends StatelessWidget {
//   const HouseCard({super.key, required this.house});
//   final House house;
//   PaymentState get latestState =>
//       getMostDelayedPaymentOrLatest(house.payments).state;
//   @override
//   Widget build(BuildContext context) {
//     if (house.payments.isNotEmpty) {
//       return Card(
//         child: ListTile(
//             // leading:
//             //     getPaymentIcon(getMostDelayedPayment(house.payments)?.state),
//             title: Text(getPaymentStatePtBr(latestState)),
//             trailing: Text(house.houseCode),
//             isThreeLine: true,
//             subtitle: HousePaymentDescription(house: house),
//             onTap: () => context.push('/houses/${house.houseCode}')),
//       );
//     }
//     return const CircularProgressIndicator();
//   }
// }