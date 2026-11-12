import '../data_sources/product_local_data_source.dart';
import '../models/product.dart';

class ProductRepository {
  final ProductLocalDataSource _dataSource;

  const ProductRepository(this._dataSource);

  List<Product> getProducts() => _dataSource.getProducts();
}
