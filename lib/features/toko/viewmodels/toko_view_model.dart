import 'package:flutter/foundation.dart';

import '../models/toko.dart';
import '../repositories/toko_repository.dart';

class TokoViewModel extends ChangeNotifier {
  static const categories = ['Semua', 'Original', 'Pedas Manis'];

  final TokoRepository _repository;

  TokoViewModel(this._repository) {
    loadTokos();
  }

  List<Toko> _tokos = [];

  String _searchQuery = '';
  String? _searchError;
  String _activeCategory = 'Semua';
  String? _loadError;

  bool _isLoading = false;
  bool _disposed = false;

  String get searchQuery => _searchQuery;
  String? get searchError => _searchError;
  String get activeCategory => _activeCategory;
  String? get loadError => _loadError;
  bool get isLoading => _isLoading;

  List<Toko> get filteredTokos {
    if (_searchError != null) return const [];

    final query = _searchQuery.trim().toLowerCase();

    return _tokos.where((toko) {
      final matchesName = toko.nama.toLowerCase().contains(query);

      final matchesCategory =
          _activeCategory == 'Semua' || toko.kategori.contains(_activeCategory);

      return matchesName && matchesCategory;
    }).toList();
  }

  Future<void> loadTokos() async {
    if (_disposed) return;

    _isLoading = true;
    _loadError = null;
    notifyListeners();

    try {
      _tokos = await _repository.getTokos();
    } catch (e) {
      _loadError = e.toString();
    }

    if (_disposed) return;

    _isLoading = false;
    notifyListeners();
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
    if (!categories.contains(category) || _activeCategory == category) {
      return;
    }

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

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
