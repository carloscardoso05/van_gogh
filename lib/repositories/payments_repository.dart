import 'package:van_gogh/entities/payment.dart';
import 'package:van_gogh/supabase.dart';
import 'package:van_gogh/transformers/payments_tranformer.dart';

abstract class PaymentsRepository {
  Future<List<Payment>> getAll();
  Future<List<Payment>> getByHouseId(int id);
  Future<Payment> getById(int id);
  Future<Payment> update(int id, Payment newPayment);
}

class LocalPaymentsRepository extends PaymentsRepository {
  @override
  Future<List<Payment>> getAll() async {
    final data = await supabase.from('payments').select('*');
    List<Payment> payments =
        data.map((e) => PaymentTranformer.fromJson(e)).toList();
    return payments;
  }

  @override
  Future<List<Payment>> getByHouseId(int id) async {
    final data = await supabase.from('payments').select('*').eq('house_id', id);
    List<Payment> payments =
        data.map((e) => PaymentTranformer.fromJson(e)).toList();
    return payments;
  }

  @override
  Future<Payment> getById(int id) async {
    final data =
        await supabase.from('payments').select('*').eq('id', id).single();
    Payment payment = PaymentTranformer.fromJson(data);
    return payment;
  }

  @override
  Future<Payment> update(int id, Payment newPayment) async {
    final data = await supabase
        .from('payments')
        .update(PaymentTranformer.toMap(newPayment))
        .eq('id', id)
        .select()
        .single();
    Payment payment = PaymentTranformer.fromJson(data);
    return payment;
  }
}
