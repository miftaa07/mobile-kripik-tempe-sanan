class Product {
  final String image; // path asset, kosongkan '' kalau belum ada
  final String name;
  final String store;
  final String variant; // rasa: Original, Pedas, dst
  final String ukuran; // Kecil / Sedang / Besar
  final int harga;
  final List<String> tujuan;

  const Product({
    this.image = '',
    required this.name,
    required this.store,
    required this.variant,
    required this.ukuran,
    required this.harga,
    this.tujuan = const [],
  });

  /// Contoh: 15000 -> "Rp 15.000" (cocok langsung ke ProductCard.price)
  String get price =>
      'Rp ${harga.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]}.')}';
}

// Data dummy bersama. Ganti image dengan path asset asli, mis. 'assets/images/tempe_original.jpg'
const daftarProduk = [
  Product(
    name: 'Keripik Tempe Original',
    store: 'Toko Sanan Jaya',
    variant: 'Original',
    ukuran: 'Sedang',
    harga: 15000,
    tujuan: ['Cemilan sendiri', 'Untuk keluarga'],
  ),
  Product(
    name: 'Keripik Tempe Pedas',
    store: 'Toko Bu Sari',
    variant: 'Pedas',
    ukuran: 'Sedang',
    harga: 18000,
    tujuan: ['Cemilan sendiri', 'Ingin mencoba'],
  ),
  Product(
    name: 'Keripik Tempe Keju',
    store: 'Toko Lestari',
    variant: 'Keju',
    ukuran: 'Besar',
    harga: 20000,
    tujuan: ['Oleh-oleh', 'Untuk keluarga'],
  ),
  Product(
    name: 'Keripik Tempe BBQ',
    store: 'Toko Sanan Jaya',
    variant: 'Barbeque',
    ukuran: 'Kecil',
    harga: 10000,
    tujuan: ['Ingin mencoba', 'Cemilan sendiri'],
  ),
  Product(
    name: 'Keripik Tempe Balado',
    store: 'Toko Berkah',
    variant: 'Balado',
    ukuran: 'Besar',
    harga: 28000,
    tujuan: ['Oleh-oleh'],
  ),
  Product(
    name: 'Paket Keripik Tempe Spesial',
    store: 'Toko Lestari',
    variant: 'Original',
    ukuran: 'Besar',
    harga: 35000,
    tujuan: ['Oleh-oleh', 'Untuk keluarga'],
  ),
];
