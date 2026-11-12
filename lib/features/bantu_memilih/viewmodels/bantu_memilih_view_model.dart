import 'package:flutter/foundation.dart';

import '../models/product_preferences.dart';

class BantuMemilihViewModel extends ChangeNotifier {
  static const budgets = [
    '<Rp10.000',
    'Rp10.000 - Rp20.000',
    'Rp20.000 - Rp30.000',
    '> Rp30.000',
  ];
  static const availableFlavors = [
    'Original',
    'Pedas',
    'Balado',
    'Keju',
    'Lainnya',
    'Barbeque',
  ];
  static const sizes = ['Kecil', 'Sedang', 'Besar', 'Bebas'];
  static const purposes = [
    'Cemilan sendiri',
    'Oleh-oleh',
    'Untuk keluarga',
    'Ingin mencoba',
  ];

  String? _budget = 'Rp10.000 - Rp20.000';
  final Set<String> _flavors = {'Original'};
  String? _size = 'Sedang';
  String? _purpose = 'Cemilan sendiri';

  String? get budget => _budget;
  Set<String> get selectedFlavors => Set.unmodifiable(_flavors);
  String? get size => _size;
  String? get purpose => _purpose;

  ProductPreferences get preferences => ProductPreferences(
    budget: _budget,
    flavors: Set.unmodifiable(_flavors),
    size: _size,
    purpose: _purpose,
  );

  void selectBudget(String value) {
    _budget = value;
    notifyListeners();
  }

  void toggleFlavor(String value) {
    if (!_flavors.add(value)) _flavors.remove(value);
    notifyListeners();
  }

  void selectSize(String value) {
    _size = value;
    notifyListeners();
  }

  void selectPurpose(String value) {
    _purpose = value;
    notifyListeners();
  }
}
