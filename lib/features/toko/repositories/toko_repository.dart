import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/hampers_item.dart';
import '../models/toko.dart';

class TokoRepository {
  static const String baseUrl = 'http://10.0.2.2:5000';

  final http.Client _client;

  TokoRepository({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Toko>> getTokos() async {
    final url = Uri.parse('$baseUrl/api/stores');

    try {
      final response = await _client
          .get(url)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Gagal mengambil toko: HTTP ${response.statusCode}');
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? 'Gagal mengambil toko');
      }

      final List<dynamic> data = responseData['data'];

      return data
          .map((item) => Toko.fromJson(item))
          .where((toko) => toko.status.toLowerCase() == 'aktif')
          .toList();
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil toko: $e');
    }
  }

  List<HampersItem> getHampers(String storeName) {
    if (storeName == 'Toko Sanan Jaya') {
      return const [
        HampersItem(
          image: 'assets/images/hampers_sanan.jpg',
          name: 'Hampers Spesial Sanan',
          store: 'Toko Sanan Jaya',
          description: 'Isi 4 varian keripik tempe',
          price: 'Rp 50.000',
        ),
      ];
    }

    if (storeName == 'Toko Bu Susi') {
      return const [
        HampersItem(
          image: 'assets/images/hampers_keluarga.jpg',
          name: 'Hampers Keluarga',
          store: 'Toko Bu Susi',
          description: 'Isi 5 varian keripik tempe',
          price: 'Rp 75.000',
        ),
      ];
    }

    return const [];
  }
}
