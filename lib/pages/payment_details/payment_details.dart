import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:van_gogh/controllers/houses_controller.dart';
import 'package:van_gogh/entities/house.dart';
import 'package:van_gogh/entities/payment.dart';
import 'package:van_gogh/get_it.dart';
import 'package:van_gogh/helpers/formating.dart';
import 'package:van_gogh/helpers/payment_helpers.dart';
import 'package:van_gogh/pages/home/admin_view/house_card.dart';
import 'package:van_gogh/repositories/payments_repository.dart';
import 'package:van_gogh/services/auth_service.dart';
import 'package:van_gogh/supabase.dart';
import 'package:http/http.dart' as http;

final acceptedFileTypes = {'pdf', 'png', 'jpeg', 'jpg'};

deleteSameNameFiles(String fullPath) async {
  final pos = fullPath.lastIndexOf('.');
  final pathWithoutSuffix = (pos != -1) ? fullPath.substring(0, pos) : fullPath;
  final paths =
      acceptedFileTypes.map((ext) => '$pathWithoutSuffix.$ext').toList();
  await supabase.storage.from('pagamentos').remove(paths);
}

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
          ActionButton(payment: payment, house: house),
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

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.payment,
    required this.house,
  });

  final Payment payment;
  final House house;

  @override
  Widget build(BuildContext context) {
    if (getIt<AuthService>().isAdmin &&
        payment.state == PaymentState.pendingVerification) {
      return Row(
        children: [
          ElevatedButton(
              onPressed: () async {
                await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Deseja confirmar esse pagamento?'),
                    content: const Text('Essa ação é inreversível'),
                    actions: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancelar')),
                      ElevatedButton(
                          onPressed: () async {
                            payment.paidDate = DateTime.now();
                            await getIt<PaymentsRepository>()
                                .update(payment.id, payment);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Confirmar')),
                    ],
                  ),
                );
              },
              child: const Text('Confirmar pagamento'))
        ],
      );
    }
    //
    if (!getIt<AuthService>().isAdmin && payment.state != PaymentState.paid) {
      return ElevatedButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
            type: FileType.custom,
          );

          if (result != null) {
            final file = result.files.single;
            if (file.bytes == null) {
              throw Exception('Arquivo vazio');
            }
            final date =
                shortDateFormat.format(payment.dueDate).replaceAll('/', '-');
            final name = 'comprovante_pagamento_$date.${file.extension}';
            if (name.contains(RegExp(r'[/\\]+'))) {
              throw Exception('Nome do arquivo não pode conter "/" nem "\\"');
            }
            final path = '${house.houseCode}/$name';
            await deleteSameNameFiles(path);
            await supabase.storage
                .from('pagamentos')
                .uploadBinary(path, file.bytes!);
            payment.filePath = name;
            await getIt<PaymentsRepository>().update(payment.id, payment);
            await getIt<HousesController>().loadHouses();
          }
        },
        child: const Text('Enviar comprovante'),
      );
    }
    return Container();
  }
}

class PaymentCard extends StatelessWidget {
  PaymentCard({
    super.key,
    required this.payment,
    required this.houseCode,
    this.clickable = true,
  });
  final Payment payment;
  final String houseCode;
  final bool clickable;
  final ShapeBorder? cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: cardShape,
      child: ListTile(
        title: PaymentStateText(state: payment.state),
        isThreeLine: true,
        subtitle: Text(getPaymentDescription(payment)),
        onTap: clickable
            ? () => context.push('/houses/$houseCode/payments/${payment.id}')
            : null,
        shape: cardShape,
      ),
    );
  }
}
