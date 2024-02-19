import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/entities/payment.dart';
import 'package:van_gogh/helpers/formating.dart';
import 'package:van_gogh/helpers/payment_helpers.dart';

class HouseCard extends StatelessWidget {
  const HouseCard({super.key, required this.house});
  final House house;
  @override
  Widget build(BuildContext context) {
    if (house.payments.isNotEmpty) {
      return Card(
        child: ListTile(
            leading:
                getPaymentIcon(getMostDelayedPayment(house.payments)?.state),
            title: Text(house.holder?.name ?? 'Sem proprietário'),
            trailing: Text(house.houseCode),
            isThreeLine: true,
            subtitle: HousePaymentDescription(house: house),
            onTap: () => context.push('/house_details', extra: house)),
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
    payment = getMostDelayedPayment(house.payments);
  }

  final House house;
  late final Payment? payment;

  @override
  Widget build(BuildContext context) {
    if (payment != null) {
      return Text(
        'Vencimento: ${dateFormat.format(payment!.dueDate)}'
        '\n'
        'Valor: ${numberFormat.format(payment!.value)}',
      );
    }
    return const Text('Pago');
  }
}
