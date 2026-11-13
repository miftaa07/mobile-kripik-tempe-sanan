import 'package:flutter_test/flutter_test.dart';
import 'package:kampung_keripik_tempe/features/bantu_memilih/data_sources/recommendation_local_data_source.dart';
import 'package:kampung_keripik_tempe/features/bantu_memilih/models/product_preferences.dart';
import 'package:kampung_keripik_tempe/features/bantu_memilih/repositories/recommendation_repository.dart';
import 'package:kampung_keripik_tempe/features/home/data_sources/home_local_data_source.dart';
import 'package:kampung_keripik_tempe/features/home/repositories/home_repository.dart';
import 'package:kampung_keripik_tempe/features/home/viewmodels/home_view_model.dart';
import 'package:kampung_keripik_tempe/features/lokasi/data_sources/location_local_data_source.dart';
import 'package:kampung_keripik_tempe/features/lokasi/repositories/location_repository.dart';
import 'package:kampung_keripik_tempe/features/pengetahuan/data_sources/knowledge_local_data_source.dart';
import 'package:kampung_keripik_tempe/features/pengetahuan/repositories/knowledge_repository.dart';
import 'package:kampung_keripik_tempe/features/toko/data_sources/product_local_data_source.dart';
import 'package:kampung_keripik_tempe/features/toko/data_sources/toko_local_data_source.dart';
import 'package:kampung_keripik_tempe/features/toko/repositories/toko_repository.dart';
import 'package:kampung_keripik_tempe/features/toko/viewmodels/toko_view_model.dart';

void main() {
  test('home view model searches the local repository', () {
    final viewModel = HomeViewModel(
      HomeRepository(const HomeLocalDataSource()),
    );

    viewModel.submitSearch('bbq');

    expect(viewModel.searchResults, hasLength(1));
    expect(viewModel.searchResults.single.title, 'Kripik Tempe BBQ');
    viewModel.dispose();
  });

  test('store view model applies category and input validation', () {
    final viewModel = TokoViewModel(
      TokoRepository(const TokoLocalDataSource()),
    );

    viewModel.selectCategory('Pedas Manis');
    expect(viewModel.filteredTokos, hasLength(2));

    viewModel.search('<invalid>');
    expect(viewModel.searchError, isNotNull);
    expect(viewModel.filteredTokos, isEmpty);

    viewModel.clearSearch();
    expect(viewModel.filteredTokos, hasLength(2));
    viewModel.dispose();
  });

  test('repositories expose the existing knowledge and location fixtures', () {
    final knowledge = KnowledgeRepository(const KnowledgeLocalDataSource())
        .getArticles();
    final guide = LocationRepository(const LocationLocalDataSource())
        .getGuide();

    expect(knowledge, hasLength(4));
    expect(guide.transportOptions, hasLength(3));
    expect(guide.address, contains('Kota Malang'));
  });

  test('recommendation repository returns ranked matching products', () {
    final repository = RecommendationRepository(
      RecommendationLocalDataSource(const ProductLocalDataSource()),
    );
    final recommendations = repository.getRecommendations(
      const ProductPreferences(
        budget: 'Rp10.000 - Rp20.000',
        flavors: {'Original'},
        size: 'Sedang',
        purpose: 'Cemilan sendiri',
      ),
    );

    expect(recommendations, hasLength(3));
    expect(recommendations.first.reasons, isNotEmpty);
    expect(
      recommendations[0].score,
      greaterThanOrEqualTo(recommendations[1].score),
    );
  });
}
