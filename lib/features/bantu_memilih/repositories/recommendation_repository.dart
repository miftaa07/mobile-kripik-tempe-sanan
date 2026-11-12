import '../data_sources/recommendation_local_data_source.dart';
import '../models/product_preferences.dart';

class RecommendationRepository {
  final RecommendationLocalDataSource _dataSource;

  const RecommendationRepository(this._dataSource);

  List<ProductRecommendation> getRecommendations(
    ProductPreferences preferences,
  ) {
    return _dataSource.getRecommendations(preferences);
  }
}
