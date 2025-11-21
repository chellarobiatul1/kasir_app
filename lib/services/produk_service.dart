
import 'supabase_service.dart';

class ProdukService {
  final supabase = SupabaseService.client;

  /// GET semua produk
  Future<List<dynamic>> getProduk() async {
    final data = await supabase.from('PRODUK').select();
    return data;
  }

  /// POST / INSERT produk baru
  Future<void> addProduk(Map<String, dynamic> body) async {
    await supabase.from('PRODUK').insert(body);
  }

  /// PATCH / UPDATE produk
  Future<void> updateProduk(String id, Map<String, dynamic> body) async {
    await supabase.from('PRODUK').update(body).eq('id', id);
  }

  /// DELETE produk
  Future<void> deleteProduk(String id) async {
    await supabase.from('PRODUK').delete().eq('id', id);
  }
}

