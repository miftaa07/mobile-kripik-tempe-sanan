import '../models/hampers_item.dart';
import '../models/toko.dart';

class TokoLocalDataSource {
  const TokoLocalDataSource();

  List<Toko> getTokos() => const [
    Toko(
      nama: 'Sentra Keripik Tempe Bu Noer',
      alamat: 'Jl. Sanan No. 121, Purwantoro, Blimbing, Malang',
      jamBuka: '07.00 - 21.00 WIB',
      lokasi: 'Sentra Utama',
      kategori: ['Original'],
      fasilitas: ['Oleh-oleh Lengkap', 'Tempat Parkir', 'Goreng Fresh'],
      gambar: 'assets/images/toko_rohani.jpg',
    ),
    Toko(
      nama: 'Keripik Tempe Rohani Sanan',
      alamat: 'Jl. Sanan No. 67, Purwantoro, Blimbing, Malang',
      jamBuka: '08.00 - 21.30 WIB',
      lokasi: 'Sejak 1988',
      kategori: ['Original', 'Pedas Manis'],
      fasilitas: ['Pelopor Rasa Daun Jeruk & Pedas Manis', 'Produksi Mandiri'],
      gambar: 'assets/images/toko_ar-ridlo.jpg',
    ),
    Toko(
      nama: 'Keripik Tempe Swari Sanan',
      alamat: 'Jl. Sanan Gang 3 No. 14, Malang',
      jamBuka: '08.00 - 17.00 WIB',
      lokasi: 'Sentra Gang 3',
      kategori: ['Original'],
      fasilitas: ['Pengrajin Rumahan', 'Bahan Kedelai Alami'],
      gambar: 'assets/images/toko_rohani.jpg',
    ),
    Toko(
      nama: 'Sentra Keripik Tempe Bu Noer',
      alamat: 'Jl. Sanan No. 121, Purwantoro, Blimbing, Malang',
      jamBuka: '07.00 - 21.00 WIB',
      lokasi: 'Sentra Utama',
      kategori: ['Original'],
      fasilitas: ['Oleh-oleh Lengkap', 'Tempat Parkir', 'Goreng Fresh'],
      gambar: 'assets/images/toko_ar-ridlo.jpg',
    ),
    Toko(
      nama: 'Keripik Tempe Rohani Sanan',
      alamat: 'Jl. Sanan No. 67, Purwantoro, Blimbing, Malang',
      jamBuka: '08.00 - 21.30 WIB',
      lokasi: 'Sejak 1988',
      kategori: ['Original', 'Pedas Manis'],
      fasilitas: ['Pelopor Rasa Daun Jeruk & Pedas Manis', 'Produksi Mandiri'],
      gambar: 'assets/images/toko_rohani.jpg',
    ),
  ];

  List<HampersItem> getHampers(String storeName) {
    if (storeName == 'Toko Sanan Jaya') {
      return const [
        HampersItem(
          image: 'assets/images/hampers_sanan.jpg',
          name: 'Hampers Spesial Sanan',
          store: 'Toko Sanan Jaya',
          description: 'Isi 4 varian keripik tempe',
          price: 'Rp 50.000',
        ),
      ];
    }
    if (storeName == 'Toko Bu Susi') {
      return const [
        HampersItem(
          image: 'assets/images/hampers_keluarga.jpg',
          name: 'Hampers Keluarga',
          store: 'Toko Bu Susi',
          description: 'Isi 5 varian keripik tempe',
          price: 'Rp 75.000',
        ),
      ];
    }
    return const [];
  }
}
