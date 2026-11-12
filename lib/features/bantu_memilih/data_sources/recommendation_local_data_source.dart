import '../../toko/repositories/product_repository.dart';
import '../models/product_preferences.dart';

class RecommendationLocalDataSource {
  final ProductRepository _productRepository;

  const RecommendationLocalDataSource(this._productRepository);

  List<ProductRecommendation> getRecommendations(
    ProductPreferences preferences,
  ) {
    final (minPrice, maxPrice) = _priceRange(preferences.budget);
    final results = <ProductRecommendation>[];

    for (final product in _productRepository.getProducts()) {
      var score = 0;
      final reasons = <String>[];
      if (product.harga >= minPrice && product.harga <= maxPrice) {
        score += 3;
        reasons.add('sesuai budget kamu');
      }
      if (preferences.flavors.contains(product.variant)) {
        score += 3;
        reasons.add('rasa ${product.variant} yang kamu pilih');
      }
      if (product.ukuran == preferences.size) {
        score += 1;
        reasons.add('ukuran ${product.ukuran.toLowerCase()}');
      }
      if (preferences.purpose != null &&
          product.tujuan.contains(preferences.purpose)) {
        score += 2;
        reasons.add('cocok untuk ${preferences.purpose!.toLowerCase()}');
      }
      if (reasons.isNotEmpty) {
        results.add(
          ProductRecommendation(
            product: product,
            reasons: reasons,
            score: score,
          ),
        );
      }
    }

    results.sort((a, b) => b.score.compareTo(a.score));
    return results.take(3).toList();
  }

  (int, int) _priceRange(String? budget) {
    switch (budget) {
      case '<Rp10.000':
        return (0, 10000);
      case 'Rp10.000 - Rp20.000':
        return (10000, 20000);
      case 'Rp20.000 - Rp30.000':
        return (20000, 30000);
      case '> Rp30.000':
        return (30000, 1 << 30);
      default:
        return (0, 1 << 30);
    }
  }
}
