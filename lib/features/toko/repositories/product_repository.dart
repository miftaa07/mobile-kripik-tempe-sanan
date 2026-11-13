import '../data_sources/product_api_data_source.dart';
import '../models/product.dart';

class ProductRepository {
  final ProductApiDataSource _dataSource;

  const ProductRepository(this._dataSource);

  Future<List<Product>> getProducts() {
    return _dataSource.getProducts();
  }
}
