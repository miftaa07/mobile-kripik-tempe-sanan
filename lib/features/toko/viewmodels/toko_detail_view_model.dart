import 'package:flutter/foundation.dart';

import '../../../core/utils/external_link_launcher.dart';
import '../models/hampers_item.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';
import '../repositories/toko_repository.dart';

class TokoDetailViewModel extends ChangeNotifier {
  final String storeName;
  final String address;
  final String phoneNumber;
  final ProductRepository _productRepository;
  final TokoRepository _tokoRepository;
  final ExternalLinkLauncher _linkLauncher;

  TokoDetailViewModel({
    required this.storeName,
    required this.address,
    required this.phoneNumber,
    required this._productRepository,
    required this._tokoRepository,
    required this._linkLauncher,
  });

  String _activeCategory = 'Semua';

  String get activeCategory => _activeCategory;

  List<String> get categories => [
    'Semua',
    ...{
      for (final product in products) product.variant,
    },
  ];

  List<Product> get products {
    final available = _productRepository
        .getProducts()
        .where((product) => !product.name.toLowerCase().contains('paket'));
    if (_activeCategory == 'Semua') return available.toList();
    return available
        .where((product) => product.variant == _activeCategory)
        .toList();
  }

  List<HampersItem> get hampers => _tokoRepository.getHampers(storeName);

  void selectCategory(String category) {
    if (!categories.contains(category) || _activeCategory == category) return;
    _activeCategory = category;
    notifyListeners();
  }

  Future<bool> contactStore() {
    final number = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final message = Uri.encodeComponent(
      'Halo, saya ingin bertanya tentang produk $storeName.',
    );
    return _linkLauncher.open(
      Uri.parse('https://wa.me/$number?text=$message'),
    );
  }

  Future<bool> openMap() {
    final query = Uri.encodeComponent(address);
    return _linkLauncher.open(
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$query'),
    );
  }
}
