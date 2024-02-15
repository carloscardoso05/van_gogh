import 'package:van_gogh/entities/resident.dart';
import 'package:van_gogh/supabase.dart';
import 'package:van_gogh/transformers/holder_transformer.dart';

abstract class HoldersRepository {
  Future<List<Holder>> getAll();
  Future<List<Holder>> getByHouseId(int id);
  Future<Holder> getById(int id);
  Future<Holder> getByUserId(int id);
  Future<void> addHolder(Holder holder);
}

class LocalHoldersRepository extends HoldersRepository {
  @override
  Future<List<Holder>> getAll() async {
    final data = await supabase.from('holders').select('*');
    List<Holder> holders =
        data.map((e) => HolderTranformer.fromJson(e)).toList();
    return holders;
  }

  @override
  Future<List<Holder>> getByHouseId(int id) async {
    final data = await supabase
        .from('holders')
        .select('*, houses!inner(holder_id)')
        .filter('id', 'eq', 'houses.holder_id');
    List<Holder> holders =
        data.map((e) => HolderTranformer.fromJson(e)).toList();
    return holders;
  }

  @override
  Future<Holder> getById(int id) async {
    final data =
        await supabase.from('holders').select('*').eq('id', id).single();
    Holder holder = HolderTranformer.fromJson(data);
    return holder;
  }

  @override
  Future<Holder> getByUserId(int id) async {
    final data =
        await supabase.from('holders').select('*').eq('user_id', id).single();
    Holder holder = HolderTranformer.fromJson(data);
    return holder;
  }

  @override
  Future<void> addHolder(Holder holder) async {
    await supabase.from('holders').insert(HolderTranformer.toMap(holder));
  }
}
