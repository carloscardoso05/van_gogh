import 'package:flutter/material.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/entities/payment.dart';
import 'package:van_gogh/helpers/payment_helpers.dart';
import 'package:van_gogh/pages/home/admin_view/house_card.dart';

class HouseDetails extends StatelessWidget {
  HouseDetails({super.key, required this.house}) {
    payment = getMostDelayedPayment(house.payments);
  }
  final House house;
  late final Payment? payment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes da casa")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text("Número: ${house.number}"),
            Text("Quadra: ${house.block}"),
            Text("Código: ${house.houseCode}"),
            Text("Proprietário: ${house.holder ?? 'Ausente'}"),
            Builder(
              builder: (context) {
                if (payment == null) {
                  return const Text("Todas as contas em dias");
                }
                return Column(
                  children: [
                    const Text('Pagamento mais atrasado'),
                    PaymentCard(payment: payment!),
                  ],
                );
              },
            ),
            const Text("Todos os pagamentos"),
            ...house.payments.map((payment) => PaymentCard(payment: payment))
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key, required this.payment});
  final Payment payment;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: PaymentStateText(state: payment.state),
        isThreeLine: true,
        subtitle: Text(getPaymentDescription(payment)),
      ),
    );
  }
}
