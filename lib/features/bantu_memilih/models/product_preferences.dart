import '../../toko/models/product.dart';

class ProductPreferences {
  final String? budget;
  final Set<String> flavors;
  final String? size;
  final String? purpose;

  const ProductPreferences({
    this.budget,
    this.flavors = const {},
    this.size,
    this.purpose,
  });
}

class ProductRecommendation {
  final Product product;
  final List<String> reasons;
  final int score;

  const ProductRecommendation({
    required this.product,
    required this.reasons,
    required this.score,
  });
}
