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

      if (response.statusCode != 200) {
        throw Exception('Gagal mengambil produk: HTTP ${response.statusCode}');
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] != true) {
        throw Exception(responseData['message'] ?? 'Gagal mengambil produk');
      }

      final List<dynamic> data = responseData['data'];

      return data.map((item) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(item);

        final String image = json['image']?.toString() ?? '';

        if (image.startsWith('/uploads/')) {
          json['image'] = '$baseUrl$image';
        }

        return Product.fromJson(json);
      }).toList();
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil produk: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
