import 'package:flutter/foundation.dart';

import '../models/toko.dart';
import '../repositories/toko_repository.dart';

class TokoViewModel extends ChangeNotifier {
  static const categories = ['Semua', 'Original', 'Pedas Manis'];

  final TokoRepository _repository;

  TokoViewModel(this._repository);

  String _searchQuery = '';
  String? _searchError;
  String _activeCategory = 'Semua';

  String get searchQuery => _searchQuery;
  String? get searchError => _searchError;
  String get activeCategory => _activeCategory;

  List<Toko> get filteredTokos {
    if (_searchError != null) return const [];
    final query = _searchQuery.trim().toLowerCase();
    return _repository.getTokos().where((toko) {
      final matchesName = toko.nama.toLowerCase().contains(query);
      final matchesCategory =
          _activeCategory == 'Semua' || toko.kategori.contains(_activeCategory);
      return matchesName && matchesCategory;
    }).toList();
  }

  void search(String value) {
    _searchQuery = value;
    _searchError = _validateSearch(value);
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _searchError = null;
    notifyListeners();
  }

  void selectCategory(String category) {
    if (!categories.contains(category) || _activeCategory == category) return;
    _activeCategory = category;
    notifyListeners();
  }

  String? _validateSearch(String value) {
    if (value.trim().isEmpty) return null;
    final pattern = RegExp(r"^[a-zA-Z0-9À-ÿ\s.,()&/-]+$");
    if (!pattern.hasMatch(value)) {
      return 'Gunakan huruf, angka, dan tanda baca yang diizinkan.';
    }
    return null;
  }
}
