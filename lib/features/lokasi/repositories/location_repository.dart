import '../data_sources/location_local_data_source.dart';
import '../models/location_guide.dart';

class LocationRepository {
  final LocationLocalDataSource _dataSource;

  const LocationRepository(this._dataSource);

  LocationGuide getGuide() => _dataSource.getGuide();
}
