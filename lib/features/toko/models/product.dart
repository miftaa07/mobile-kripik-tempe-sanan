class Product {
  final int id;
  final int storeId;
  final String image;
  final String name;
  final String store;
  final String variant;
  final String ukuran;
  final int harga;
  final List<String> tujuan;

  const Product({
    this.id = 0,
    this.storeId = 0,
    this.image = '',
    required this.name,
    required this.store,
    required this.variant,
    required this.ukuran,
    required this.harga,
    this.tujuan = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.tryParse('${json['id']}') ?? 0,
      storeId: int.tryParse('${json['store_id']}') ?? 0,
      image: json['image']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      store: json['store_name']?.toString() ?? '',
      variant: json['variant']?.toString() ?? 'Original',
      ukuran: json['size']?.toString() ?? 'Sedang',
      harga: (double.tryParse('${json['price']}') ?? 0).round(),
      tujuan: const [],
    );
  }

  String get price =>
      'Rp ${harga.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]}.')}';
}
