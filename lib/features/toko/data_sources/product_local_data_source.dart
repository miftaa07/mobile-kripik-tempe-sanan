import '../models/product.dart';

class ProductLocalDataSource {
  const ProductLocalDataSource();

  List<Product> getProducts() => const [
    Product(
      image: 'assets/images/tempe_original.jpg',
      name: 'Keripik Tempe Original',
      store: 'Toko Sanan Jaya',
      variant: 'Original',
      ukuran: 'Sedang',
      harga: 15000,
      tujuan: ['Cemilan sendiri', 'Untuk keluarga'],
    ),
    Product(
      image: 'assets/images/tempe_original.jpg',
      name: 'Keripik Tempe Pedas',
      store: 'Toko Bu Sari',
      variant: 'Pedas',
      ukuran: 'Sedang',
      harga: 18000,
      tujuan: ['Cemilan sendiri', 'Ingin mencoba'],
    ),
    Product(
      image: 'assets/images/tempe_original.jpg',
      name: 'Keripik Tempe Keju',
      store: 'Toko Lestari',
      variant: 'Keju',
      ukuran: 'Besar',
      harga: 20000,
      tujuan: ['Oleh-oleh', 'Untuk keluarga'],
    ),
    Product(
      image: 'assets/images/tempe_bbq.jpg',
      name: 'Keripik Tempe BBQ',
      store: 'Toko Sanan Jaya',
      variant: 'Barbeque',
      ukuran: 'Kecil',
      harga: 10000,
      tujuan: ['Ingin mencoba', 'Cemilan sendiri'],
    ),
    Product(
      image: 'assets/images/tempe_original.jpg',
      name: 'Keripik Tempe Balado',
      store: 'Toko Berkah',
      variant: 'Balado',
      ukuran: 'Besar',
      harga: 28000,
      tujuan: ['Oleh-oleh'],
    ),
    Product(
      image: 'assets/images/hampers_sanan.jpg',
      name: 'Paket Keripik Tempe Spesial',
      store: 'Toko Lestari',
      variant: 'Original',
      ukuran: 'Besar',
      harga: 35000,
      tujuan: ['Oleh-oleh', 'Untuk keluarga'],
    ),
  ];
}
