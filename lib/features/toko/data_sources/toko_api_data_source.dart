import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/toko.dart';

class TokoApiDataSource {
  static const String baseUrl = 'http://10.0.2.2:5000';

  final http.Client _client;

  TokoApiDataSource({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Toko>> getTokos() async {
    final url = Uri.parse('$baseUrl/api/stores');

    try {
      final response = await _client
          .get(url)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['success'] != true) {
          throw Exception(responseData['message']);
        }

        final List<dynamic> data = responseData['data'];

        return data
            .map((item) => Toko.fromJson(item))
            .where((toko) => toko.status.toLowerCase() == 'aktif')
            .toList();
      }

      throw Exception('Gagal mengambil toko: HTTP ${response.statusCode}');
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil toko: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
