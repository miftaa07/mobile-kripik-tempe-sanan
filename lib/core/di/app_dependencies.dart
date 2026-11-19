import '../utils/external_link_launcher.dart';

import '../../features/bantu_memilih/repositories/recommendation_repository.dart';
import '../../features/home/repositories/home_repository.dart';
import '../../features/lokasi/repositories/location_repository.dart';
import '../../features/pengetahuan/repositories/knowledge_repository.dart';

import '../../features/toko/data_sources/product_local_data_source.dart';
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
    final productRepository = ProductRepository();
    final tokoRepository = TokoRepository();

    return AppDependencies(
      externalLinkLauncher: linkLauncher,
      productRepository: productRepository,
      tokoRepository: tokoRepository,
      homeRepository: const HomeRepository(),
      knowledgeRepository: const KnowledgeRepository(),
      locationRepository: const LocationRepository(),
      recommendationRepository: RecommendationRepository(
        const ProductLocalDataSource(),
      ),
    );
  }
}
