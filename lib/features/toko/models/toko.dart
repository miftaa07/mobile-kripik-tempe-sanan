class Toko {
  final int id;
  final String nama;
  final String pemilik;
  final String alamat;
  final String jamBuka;
  final String lokasi;
  final List<String> kategori;
  final List<String> fasilitas;
  final String gambar;
  final String? whatsapp;
  final String? gmapsLink;
  final String? deskripsi;
  final String status;
  final int productCount;

  const Toko({
    this.id = 0,
    required this.nama,
    this.pemilik = '',
    required this.alamat,
    this.jamBuka = 'Informasi belum tersedia',
    required this.lokasi,
    this.kategori = const [],
    this.fasilitas = const [],
    required this.gambar,
    this.whatsapp,
    this.gmapsLink,
    this.deskripsi,
    this.status = 'Aktif',
    this.productCount = 0,
  });

  factory Toko.fromJson(Map<String, dynamic> json) {
    List<String> parseList(dynamic value) {
      if (value is List) {
        return value.map((item) => item.toString()).toList();
      }

      if (value is String && value.isNotEmpty) {
        return value.split(',').map((item) => item.trim()).toList();
      }

      return [];
    }

    return Toko(
      id: int.tryParse('${json['id']}') ?? 0,
      nama: json['name']?.toString() ?? '',
      pemilik: json['owner']?.toString() ?? '',
      alamat: json['address']?.toString() ?? '',
      lokasi: json['area']?.toString() ?? '',
      gambar: json['image']?.toString() ?? '',
      whatsapp: json['whatsapp']?.toString(),
      gmapsLink: json['gmaps_link']?.toString(),
      deskripsi: json['description']?.toString(),
      status: json['status']?.toString() ?? 'Aktif',
      productCount: int.tryParse('${json['product_count']}') ?? 0,
      jamBuka: json['opening_hours']?.toString() ?? 'Informasi belum tersedia',
      kategori: parseList(json['categories'] ?? json['category']),
      fasilitas: parseList(json['facilities'] ?? json['facility']),
    );
  }
}
