import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductApiDataSource {
  static const String baseUrl = 'http://10.0.2.2:5000';

  final http.Client _client;

  ProductApiDataSource({http.Client? client})
    : _client = client ?? http.Client();

  Future<List<Product>> getProducts() async {
    final url = Uri.parse('$baseUrl/api/products');

    try {
      final response = await _client
          .get(url)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((item) => Product.fromJson(item)).toList();
      }

      throw Exception('Gagal mengambil produk: HTTP ${response.statusCode}');
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil produk: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
