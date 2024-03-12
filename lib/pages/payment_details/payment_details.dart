import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/entities/payment.dart';
import 'package:van_gogh/helpers/payment_helpers.dart';
import 'package:van_gogh/pages/home/admin_view/house_card.dart';
import 'package:van_gogh/supabase.dart';
import 'package:http/http.dart' as http;

final acceptedFileTypes = {'pdf', 'png', 'jpeg', 'jpg'};

class PaymentDetails extends StatelessWidget {
  PaymentDetails({super.key, required this.payment, required this.house}) {
    url = supabase.storage
        .from('pagamentos')
        .getPublicUrl('${house.houseCode}/${payment.filePath}');
  }
  final Payment payment;
  final House house;
  late final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do pagamento'),
      ),
      body: Column(
        children: [
          PaymentCard(
            payment: payment,
            houseCode: house.houseCode,
            clickable: false,
          ),
          Expanded(
            child: FutureBuilder(
              future: http.get(Uri.parse(url)),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const CircularProgressIndicator();
                }
                final code = snapshot.data!.statusCode;
                if (code != 200) {
                  return const Text('Documento não encontrado');
                }

                final extension = url.split('.').last;
                if (!acceptedFileTypes.contains(extension)) {
                  return const Text('Documento inválido');
                }
                if (extension == 'pdf') {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: SfPdfViewer.network(url),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.network(url),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.payment,
    required this.houseCode,
    this.clickable = true,
  });
  final Payment payment;
  final String houseCode;
  final bool clickable;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: PaymentStateText(state: payment.state),
        isThreeLine: true,
        subtitle: Text(getPaymentDescription(payment)),
        onTap: clickable
            ? () => context.push('/houses/$houseCode/payments/${payment.id}')
            : null,
      ),
    );
  }
}