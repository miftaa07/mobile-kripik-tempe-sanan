import '../data_sources/home_local_data_source.dart';
import '../models/home_search_item.dart';
import '../models/home_store_highlight.dart';
import '../../toko/models/hampers_item.dart';
import '../../toko/models/product.dart';

class HomeRepository {
  final HomeLocalDataSource _dataSource;

  const HomeRepository(this._dataSource);

  List<HomeSearchItem> getSearchItems() => _dataSource.getSearchItems();

  List<Product> getFeaturedProducts() => _dataSource.getFeaturedProducts();

  List<HampersItem> getFeaturedHampers() => _dataSource.getFeaturedHampers();

  List<HomeStoreHighlight> getFeaturedStores() =>
      _dataSource.getFeaturedStores();
}
