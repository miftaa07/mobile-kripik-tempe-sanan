import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:kampung_keripik_tempe/features/bantu_memilih/models/product_preferences.dart';
import 'package:kampung_keripik_tempe/features/bantu_memilih/repositories/recommendation_repository.dart';
import 'package:kampung_keripik_tempe/features/home/repositories/home_repository.dart';
import 'package:kampung_keripik_tempe/features/home/viewmodels/home_view_model.dart';
import 'package:kampung_keripik_tempe/features/lokasi/repositories/location_repository.dart';
import 'package:kampung_keripik_tempe/features/pengetahuan/repositories/knowledge_repository.dart';
import 'package:kampung_keripik_tempe/features/toko/data_sources/product_local_data_source.dart';
import 'package:kampung_keripik_tempe/features/toko/repositories/toko_repository.dart';
import 'package:kampung_keripik_tempe/features/toko/viewmodels/toko_view_model.dart';

void main() {
  test('home view model searches the local repository', () {
    final viewModel = HomeViewModel(const HomeRepository());

    viewModel.submitSearch('bbq');

    expect(viewModel.searchResults, hasLength(1));
    expect(viewModel.searchResults.single.title, 'Kripik Tempe BBQ');

    viewModel.dispose();
  });

  test('store view model applies category and input validation', () async {
    final mockClient = MockClient((request) async {
      return http.Response(
        jsonEncode({
          'success': true,
          'data': [
            {
              'id': 1,
              'name': 'Toko Sanan Jaya',
              'address': 'Jl. Sanan Malang',
              'area': 'Sentra Utama',
              'image': 'toko1.jpg',
              'status': 'Aktif',
              'categories': ['Original', 'Pedas Manis'],
            },
            {
              'id': 2,
              'name': 'Toko Bu Susi',
              'address': 'Jl. Sanan Malang',
              'area': 'Sentra Gang 3',
              'image': 'toko2.jpg',
              'status': 'Aktif',
              'categories': ['Pedas Manis'],
            },
          ],
        }),
        200,
      );
    });

    final viewModel = TokoViewModel(TokoRepository(client: mockClient));

    // Tunggu loading API mock selesai.
    while (viewModel.isLoading) {
      await Future<void>.delayed(Duration.zero);
    }

    expect(viewModel.loadError, isNull);

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
    final knowledge = const KnowledgeRepository().getArticles();

    final guide = const LocationRepository().getGuide();

    expect(knowledge, hasLength(4));
    expect(guide.transportOptions, hasLength(3));
    expect(guide.address, contains('Kota Malang'));
  });

  test('recommendation repository returns ranked matching products', () {
    final repository = RecommendationRepository(const ProductLocalDataSource());

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
