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
