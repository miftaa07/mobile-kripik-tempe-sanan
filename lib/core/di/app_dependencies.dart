import '../utils/external_link_launcher.dart';

import '../../features/bantu_memilih/data_sources/recommendation_local_data_source.dart';
import '../../features/bantu_memilih/repositories/recommendation_repository.dart';

import '../../features/home/data_sources/home_local_data_source.dart';
import '../../features/home/repositories/home_repository.dart';

import '../../features/lokasi/data_sources/location_local_data_source.dart';
import '../../features/lokasi/repositories/location_repository.dart';

import '../../features/pengetahuan/data_sources/knowledge_local_data_source.dart';
import '../../features/pengetahuan/repositories/knowledge_repository.dart';

import '../../features/toko/data_sources/product_api_data_source.dart';
import '../../features/toko/data_sources/product_local_data_source.dart';
import '../../features/toko/data_sources/toko_local_data_source.dart';
import '../../features/toko/repositories/product_repository.dart';
import '../../features/toko/repositories/toko_repository.dart';

class AppDependencies {
  const AppDependencies({
    required this.externalLinkLauncher,
    required this.productRepository,
    required this.tokoRepository,
    required this.homeRepository,
    required this.knowledgeRepository,
    required this.locationRepository,
    required this.recommendationRepository,
  });

  static final AppDependencies instance = _createDefault();

  final ExternalLinkLauncher externalLinkLauncher;
  final ProductRepository productRepository;
  final TokoRepository tokoRepository;
  final HomeRepository homeRepository;
  final KnowledgeRepository knowledgeRepository;
  final LocationRepository locationRepository;
  final RecommendationRepository recommendationRepository;

  static AppDependencies _createDefault() {
    final linkLauncher = ExternalLinkLauncher();
    final productRepository = ProductRepository(ProductApiDataSource());

    return AppDependencies(
      externalLinkLauncher: linkLauncher,
      productRepository: productRepository,
      tokoRepository: TokoRepository(const TokoLocalDataSource()),
      homeRepository: HomeRepository(const HomeLocalDataSource()),
      knowledgeRepository: KnowledgeRepository(
        const KnowledgeLocalDataSource(),
      ),
      locationRepository: LocationRepository(const LocationLocalDataSource()),
      recommendationRepository: RecommendationRepository(
        RecommendationLocalDataSource(const ProductLocalDataSource()),
      ),
    );
  }
}
