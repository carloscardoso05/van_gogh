import 'package:flutter/material.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/entities/payment.dart';
import 'package:van_gogh/helpers/payment_helpers.dart';
import 'package:van_gogh/pages/payment_details/payment_details.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      PaymentCard(
                        payment: payment!,
                        houseCode: house.houseCode,
                      ),
                    ],
                  );
                },
              ),
              const Text(
                "Todos os pagamentos",
                textAlign: TextAlign.center,
              ),
              ...house.payments.map((payment) =>
                  PaymentCard(payment: payment, houseCode: house.houseCode))
            ],
          ),
        ),
      ),
    );
  }
}
