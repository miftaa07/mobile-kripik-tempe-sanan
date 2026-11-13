import '../models/home_search_item.dart';
import '../models/home_store_highlight.dart';
import '../../toko/models/hampers_item.dart';
import '../../toko/models/product.dart';

class HomeLocalDataSource {
  const HomeLocalDataSource();

  List<HomeSearchItem> getSearchItems() => const [
    HomeSearchItem(
      title: 'Kripik Tempe Original',
      subtitle: 'Toko Sanan Jaya',
      category: 'Original',
      price: 'Rp 10.000',
      image: 'assets/images/tempe_original.jpg',
    ),
    HomeSearchItem(
      title: 'Kripik Tempe BBQ',
      subtitle: 'Toko Bu Susi',
      category: 'BBQ',
      price: 'Rp 10.000',
      image: 'assets/images/tempe_bbq.jpg',
    ),
    HomeSearchItem(
      title: 'Kripik Tempe Pedas',
      subtitle: 'Toko Pak Rudi',
      category: 'Pedas',
      price: 'Rp 10.000',
      image: 'assets/images/tempe_original.jpg',
    ),
    HomeSearchItem(
      title: 'Hampers Spesial Sanan',
      subtitle: 'Toko Sanan Jaya · Isi 4 varian keripik tempe',
      category: 'Hampers',
      price: 'Rp 50.000',
      image: 'assets/images/hampers_sanan.jpg',
    ),
    HomeSearchItem(
      title: 'Hampers Keluarga',
      subtitle: 'Toko Bu Susi · Isi 5 varian keripik tempe',
      category: 'Hampers',
      price: 'Rp 75.000',
      image: 'assets/images/hampers_keluarga.jpg',
    ),
    HomeSearchItem(
      title: 'Toko Sanan Jaya',
      subtitle: 'Jl. Sanan No. 12, Malang',
      category: 'Toko',
      image: 'assets/images/toko_rohani.jpg',
    ),
    HomeSearchItem(
      title: 'Toko Ar - Ridlo',
      subtitle: 'Jl. Sanan No. 28, Malang',
      category: 'Toko',
      image: 'assets/images/toko_ar-ridlo.jpg',
    ),
    HomeSearchItem(
      title: 'Kenali Kampung Sanan',
      subtitle: 'Kawasan yang dikenal sebagai sentra industri keripik tempe di Malang.',
      category: 'Informasi',
      image: 'assets/images/kampung_sanan.jpg',
    ),
    HomeSearchItem(
      title: 'Asisten Cerdas Sanan',
      subtitle: 'Temukan toko atau produk keripik tempe sesuai kebutuhanmu.',
      category: 'Informasi',
      image: 'assets/images/robot.png',
    ),
  ];

  List<Product> getFeaturedProducts() => const [
    Product(
      image: 'assets/images/tempe_original.jpg',
      name: 'Kripik Tempe Original',
      store: 'Toko Sanan Jaya',
      variant: 'Original',
      ukuran: 'Sedang',
      harga: 10000,
    ),
    Product(
      image: 'assets/images/tempe_bbq.jpg',
      name: 'Kripik Tempe BBQ',
      store: 'Toko Bu Susi',
      variant: 'BBQ',
      ukuran: 'Sedang',
      harga: 10000,
    ),
    Product(
      image: 'assets/images/tempe_original.jpg',
      name: 'Kripik Tempe Pedas',
      store: 'Toko Pak Rudi',
      variant: 'Pedas',
      ukuran: 'Sedang',
      harga: 10000,
    ),
  ];

  List<HampersItem> getFeaturedHampers() => const [
    HampersItem(
      image: 'assets/images/hampers_sanan.jpg',
      name: 'Hampers Spesial Sanan',
      store: 'Toko Sanan Jaya',
      description: 'Isi 4 varian keripik tempe',
      price: 'Rp 50.000',
    ),
    HampersItem(
      image: 'assets/images/hampers_keluarga.jpg',
      name: 'Hampers Keluarga',
      store: 'Toko Bu Susi',
      description: 'Isi 5 varian keripik tempe',
      price: 'Rp 75.000',
    ),
    HampersItem(
      image: 'assets/images/hampers_sanan.jpg',
      name: 'Hampers Spesial Sanan',
      store: 'Toko Sanan Jaya',
      description: 'Isi 4 varian keripik tempe',
      price: 'Rp 50.000',
    ),
  ];

  List<HomeStoreHighlight> getFeaturedStores() => const [
    HomeStoreHighlight(
      name: 'Toko Sanan Jaya',
      image: 'assets/images/toko_rohani.jpg',
      address: 'Jl. Sanan No. 12, Malang',
      openingHours: '07.00 - 21.00 WIB',
      description: 'Toko legendaris dengan berbagai varian keripik tempe.',
      detailDescription: 'Toko legendaris dengan berbagai varian keripik tempe khas Kampung Sanan.',
    ),
    HomeStoreHighlight(
      name: 'Toko Ar - Ridlo',
      image: 'assets/images/toko_ar-ridlo.jpg',
      address: 'Jl. Sanan No. 28, Malang',
      openingHours: '08.00 - 21.30 WIB',
      description: 'Terkenal dengan rasa khas dan kualitas terjaga.',
      detailDescription: 'Toko keripik tempe Sanan dengan rasa khas dan kualitas yang selalu terjaga.',
    ),
    HomeStoreHighlight(
      name: 'Toko Sanan Jaya',
      image: 'assets/images/toko_rohani.jpg',
      address: 'Jl. Sanan No. 12, Malang',
      openingHours: '07.00 - 21.00 WIB',
      description: 'Toko legendaris dengan berbagai varian keripik tempe.',
      detailDescription: 'Toko legendaris dengan berbagai varian keripik tempe khas Kampung Sanan.',
    ),
  ];
}
