import 'package:flutter/material.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/helpers/formating.dart';
import 'package:van_gogh/helpers/payment_helpers.dart';

class HouseDetails extends StatelessWidget {
  const HouseDetails({super.key, required this.house});
  final House house;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes da casa")),
      body: Column(
        children: [
          Text("Número: ${house.number}"),
          Text("Quadra: ${house.block}"),
          Text("Código: ${house.houseCode}"),
          Text("Proprietário: ${house.holder ?? 'Ausente'}"),
          Builder(
            builder: (context) {
              final payment = getMostDelayedPayment(house.payments);
              if (payment == null) {
                return const Text("Todas as contas em dias");
              }
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                          "Vencimento: ${extendedDateFormat.format(payment.dueDate)}"),
                      Text(getPaymentStatePtBr(payment.state)),
                      Text("Valor: R\$${numberFormat.format(payment.value)}")
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
