import '../data_sources/toko_api_data_source.dart';
import '../data_sources/toko_local_data_source.dart';
import '../models/hampers_item.dart';
import '../models/toko.dart';

class TokoRepository {
  final TokoApiDataSource _apiDataSource;
  final TokoLocalDataSource _localDataSource;

  TokoRepository(this._apiDataSource, this._localDataSource);

  Future<List<Toko>> getTokos() {
    return _apiDataSource.getTokos();
  }

  List<HampersItem> getHampers(String storeName) {
    return _localDataSource.getHampers(storeName);
  }
}
