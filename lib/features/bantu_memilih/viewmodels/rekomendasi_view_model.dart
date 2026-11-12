import '../models/product_preferences.dart';
import '../repositories/recommendation_repository.dart';

class RekomendasiViewModel {
  final RecommendationRepository _repository;
  final ProductPreferences preferences;

  const RekomendasiViewModel(this._repository, this.preferences);

  List<ProductRecommendation> get recommendations {
    return _repository.getRecommendations(preferences);
  }
}
