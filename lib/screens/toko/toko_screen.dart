import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class TokoScreen extends StatefulWidget {
  const TokoScreen({super.key});

  @override
  State<TokoScreen> createState() => _TokoScreenState();
}

class _TokoScreenState extends State<TokoScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _kategoriAktif = 'Semua';

  final List<String> _kategori = const [
    'Semua',
    'Original',
    'Pedas Manis',
  ];

  final List<_DataToko> _daftarToko = const [
    _DataToko(
      nama: 'Sentra Keripik Tempe Bu Noer',
      alamat: 'Jl. Sanan No. 121, Purwantoro, Blimbing, Malang',
      jamBuka: '07.00 - 21.00 WIB',
      lokasi: 'Sentra Utama',
      kategori: ['Original'],
      fasilitas: ['Oleh-oleh Lengkap', 'Tempat Parkir', 'Goreng Fresh'],
      gambar: 'assets/images/toko_rohani.jpg',
    ),
    _DataToko(
      nama: 'Keripik Tempe Rohani Sanan',
      alamat: 'Jl. Sanan No. 67, Purwantoro, Blimbing, Malang',
      jamBuka: '08.00 - 21.30 WIB',
      lokasi: 'Sejak 1988',
      kategori: ['Original', 'Pedas Manis'],
      fasilitas: ['Pelopor Rasa Daun Jeruk & Pedas Manis', 'Produksi Mandiri'],
      gambar: 'assets/images/toko_ar-ridlo.jpg',
    ),
    _DataToko(
      nama: 'Keripik Tempe Swari Sanan',
      alamat: 'Jl. Sanan Gang 3 No. 14, Malang',
      jamBuka: '08.00 - 17.00 WIB',
      lokasi: 'Sentra Gang 3',
      kategori: ['Original'],
      fasilitas: ['Pengrajin Rumahan', 'Bahan Kedelai Alami'],
      gambar: 'assets/images/toko_rohani.jpg',
    ),
    _DataToko(
      nama: 'Sentra Keripik Tempe Bu Noer',
      alamat: 'Jl. Sanan No. 121, Purwantoro, Blimbing, Malang',
      jamBuka: '07.00 - 21.00 WIB',
      lokasi: 'Sentra Utama',
      kategori: ['Original'],
      fasilitas: ['Oleh-oleh Lengkap', 'Tempat Parkir', 'Goreng Fresh'],
      gambar: 'assets/images/toko_ar-ridlo.jpg',
    ),
    _DataToko(
      nama: 'Keripik Tempe Rohani Sanan',
      alamat: 'Jl. Sanan No. 67, Purwantoro, Blimbing, Malang',
      jamBuka: '08.00 - 21.30 WIB',
      lokasi: 'Sejak 1988',
      kategori: ['Original', 'Pedas Manis'],
      fasilitas: ['Pelopor Rasa Daun Jeruk & Pedas Manis', 'Produksi Mandiri'],
      gambar: 'assets/images/toko_rohani.jpg',
    ),
  ];

  List<_DataToko> get _tokoTerfilter {
    final kataKunci = _searchController.text.trim().toLowerCase();

    return _daftarToko.where((toko) {
      final cocokNama = toko.nama.toLowerCase().contains(kataKunci);
      final cocokKategori = _kategoriAktif == 'Semua' ||
          toko.kategori.contains(_kategoriAktif);

      return cocokNama && cocokKategori;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final toko = _tokoTerfilter;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchField(),
            _buildCategoryFilters(),
            const SizedBox(height: 16),
            Expanded(
              child: toko.isEmpty
                  ? const Center(
                      child: Text(
                        'Toko tidak ditemukan',
                        style: TextStyle(color: AppTheme.textGrey),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      itemCount: toko.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        return _buildStoreCard(toko[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 20, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.primary,
            tooltip: 'Kembali',
          ),
          const SizedBox(width: 4),
          const Text(
            'Toko',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(27, 4, 27, 0),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: 'Cari toko...',
          hintStyle: const TextStyle(
            fontSize: 14,
            color: AppTheme.textGrey,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 21,
            color: AppTheme.textDark,
          ),
          filled: true,
          fillColor: const Color(0xFFF3F0EF),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 58,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(27, 14, 20, 4),
        scrollDirection: Axis.horizontal,
        itemCount: _kategori.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = _kategori[index];
          final terpilih = item == _kategoriAktif;

          return ChoiceChip(
            label: Text(item),
            selected: terpilih,
            showCheckmark: false,
            onSelected: (_) {
              setState(() {
                _kategoriAktif = item;
              });
            },
            labelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: terpilih ? Colors.white : AppTheme.textDark,
            ),
            backgroundColor: Colors.white,
            selectedColor: AppTheme.primary,
            side: BorderSide(
              color: terpilih
                  ? AppTheme.primary
                  : const Color(0xFFE8D8CC),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoreCard(_DataToko toko) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDE8E4)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(14),
            ),
            child: SizedBox(
              height: 164,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    toko.gambar,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: const Color(0xFFF3EEE9),
                        child: const Icon(
                          Icons.storefront_outlined,
                          size: 48,
                          color: Color(0xFFB7ADA5),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 10,
                    left: 11,
                    child: _imageLabel(
                      icon: Icons.circle,
                      text: 'Buka • ${toko.jamBuka}',
                      backgroundColor: const Color(0xFFF8F8EF),
                      iconColor: const Color(0xFF83A65B),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _imageLabel(
                      icon: Icons.storefront,
                      text: toko.lokasi,
                      backgroundColor: const Color(0xB3201D1B),
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  toko.nama,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        toko.alamat,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.textGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: toko.fasilitas
                      .map((fasilitas) => _featureTag(fasilitas))
                      .toList(),
                ),
                const SizedBox(height: 13),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Detail ${toko.nama}'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward, size: 17),
                    label: const Text(
                      'Lihat Detail Toko',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageLabel({
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color iconColor,
    Color textColor = AppTheme.textDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: iconColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF4ECE8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFF65534A),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _DataToko {
  final String nama;
  final String alamat;
  final String jamBuka;
  final String lokasi;
  final List<String> kategori;
  final List<String> fasilitas;
  final String gambar;

  const _DataToko({
    required this.nama,
    required this.alamat,
    required this.jamBuka,
    required this.lokasi,
    required this.kategori,
    required this.fasilitas,
    required this.gambar,
  });
}