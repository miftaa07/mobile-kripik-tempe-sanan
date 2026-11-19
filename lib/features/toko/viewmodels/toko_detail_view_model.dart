import 'package:flutter/foundation.dart';

import '../../../core/utils/external_link_launcher.dart';
import '../models/hampers_item.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';
import '../repositories/toko_repository.dart';

class TokoDetailViewModel extends ChangeNotifier {
  final int? storeId;
  final String storeName;
  final String address;
  final String phoneNumber;

  final ProductRepository productRepository;
  final TokoRepository tokoRepository;
  final ExternalLinkLauncher linkLauncher;

  TokoDetailViewModel({
    this.storeId,
    required this.storeName,
    required this.address,
    required this.phoneNumber,
    required this.productRepository,
    required this.tokoRepository,
    required this.linkLauncher,
  });

  String _activeCategory = 'Semua';
  List<Product> _allProducts = [];
  bool _isLoading = false;
  bool _disposed = false;
  String? _errorMessage;

  String get activeCategory => _activeCategory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<String> get categories {
    return [
      'Semua',
      ...{for (final product in _allProducts) product.variant},
    ];
  }

  List<Product> get products {
    final available = _allProducts.where(
      (product) => !product.name.toLowerCase().contains('paket'),
    );

    if (_activeCategory == 'Semua') {
      return available.toList();
    }

    return available
        .where((product) => product.variant == _activeCategory)
        .toList();
  }

  List<HampersItem> get hampers => tokoRepository.getHampers(storeName);

  Future<void> loadProducts() async {
    if (_disposed) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await productRepository.getProducts();

      if (_disposed) return;

      _allProducts = result.where((product) {
        if (storeId != null && storeId! > 0) {
          return product.storeId == storeId;
        }

        return product.store.trim().toLowerCase() ==
            storeName.trim().toLowerCase();
      }).toList();
    } catch (e) {
      if (_disposed) return;
      _errorMessage = e.toString();
    } finally {
      if (!_disposed) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  void selectCategory(String category) {
    if (!categories.contains(category) || _activeCategory == category) {
      return;
    }

    _activeCategory = category;
    notifyListeners();
  }

  Future<bool> contactStore() {
    final number = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final message = Uri.encodeComponent(
      'Halo, saya ingin bertanya tentang produk $storeName.',
    );

    return linkLauncher.open(Uri.parse('https://wa.me/$number?text=$message'));
  }

  Future<bool> openMap() {
    final query = Uri.encodeComponent(address);

    return linkLauncher.open(
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$query'),
    );
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
