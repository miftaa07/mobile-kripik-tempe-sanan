import 'package:flutter/foundation.dart';

import '../models/home_search_item.dart';
import '../models/home_store_highlight.dart';
import '../repositories/home_repository.dart';
import '../../toko/models/hampers_item.dart';
import '../../toko/models/product.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository;

  HomeViewModel(this._repository);

  String _submittedQuery = '';

  String get submittedQuery => _submittedQuery;
  List<Product> get featuredProducts => _repository.getFeaturedProducts();
  List<HampersItem> get featuredHampers => _repository.getFeaturedHampers();
  List<HomeStoreHighlight> get featuredStores =>
      _repository.getFeaturedStores();

  List<HomeSearchItem> get searchResults {
    final query = _submittedQuery.trim().toLowerCase();
    if (query.isEmpty) return const [];

    return _repository.getSearchItems().where((item) {
      return '${item.title} ${item.subtitle} ${item.category} '
              '${item.price ?? ''} Keripik Tempe'
          .toLowerCase()
          .contains(query);
    }).toList();
  }

  void submitSearch(String value) {
    _submittedQuery = value.trim();
    notifyListeners();
  }

  void clearSubmittedSearch() {
    if (_submittedQuery.isEmpty) return;
    _submittedQuery = '';
    notifyListeners();
  }
}
