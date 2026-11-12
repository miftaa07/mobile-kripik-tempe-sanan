import '../data_sources/toko_local_data_source.dart';
import '../models/hampers_item.dart';
import '../models/toko.dart';

class TokoRepository {
  final TokoLocalDataSource _dataSource;

  const TokoRepository(this._dataSource);

  List<Toko> getTokos() => _dataSource.getTokos();

  List<HampersItem> getHampers(String storeName) {
    return _dataSource.getHampers(storeName);
  }
}
