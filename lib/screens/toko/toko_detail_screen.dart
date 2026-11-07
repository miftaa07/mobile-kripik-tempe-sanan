import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/product.dart';
import '../../theme/app_theme.dart';
import '../../widgets/hampers_card.dart';

class TokoDetailScreen extends StatefulWidget {
  final String nama;
  final String gambar;
  final String alamat;
  final String jamBuka;
  final String deskripsi;
  final String nomorWhatsApp;

  const TokoDetailScreen({
    super.key,
    required this.nama,
    required this.gambar,
    required this.alamat,
    required this.jamBuka,
    required this.deskripsi,
    this.nomorWhatsApp = '6281234567890',
  });

  @override
  State<TokoDetailScreen> createState() => _TokoDetailScreenState();
}

class _TokoDetailScreenState extends State<TokoDetailScreen> {
  String _kategoriAktif = 'Semua';

  List<Product> get _produk {
    final produk = daftarProduk
        .where((item) => !item.name.toLowerCase().contains('paket'))
        .toList();
    if (_kategoriAktif == 'Semua') return produk;
    return produk.where((item) => item.variant == _kategoriAktif).toList();
  }

  List<HampersCard> get _hampers {
    if (widget.nama == 'Toko Sanan Jaya') {
      return const [
        HampersCard(
          image: 'assets/images/hampers_sanan.jpg',
          name: 'Hampers Spesial Sanan',
          store: 'Toko Sanan Jaya',
          description: 'Isi 4 varian keripik tempe',
          price: 'Rp 50.000',
        ),
      ];
    }
    if (widget.nama == 'Toko Bu Susi') {
      return const [
        HampersCard(
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

  Future<void> _openLink(Uri uri) async {
    final berhasil = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!berhasil && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka aplikasi terkait.')),
      );
    }
  }

  Future<void> _hubungiToko() {
    final nomor = widget.nomorWhatsApp.replaceAll(RegExp(r'[^0-9]'), '');
    final pesan = Uri.encodeComponent(
      'Halo, saya ingin bertanya tentang produk ${widget.nama}.',
    );
    return _openLink(Uri.parse('https://wa.me/$nomor?text=$pesan'));
  }

  Future<void> _bukaPeta() {
    final query = Uri.encodeComponent(widget.alamat);
    return _openLink(
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$query'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildStoreIntroduction()),
            SliverToBoxAdapter(child: _buildStoreInformation()),
            SliverToBoxAdapter(child: _buildLocation()),
            SliverToBoxAdapter(child: _buildCatalogHeader()),
            SliverToBoxAdapter(child: _buildCategoryFilters()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(19, 8, 19, 20),
              sliver: _produk.isEmpty
                  ? const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            'Belum ada produk pada kategori ini.',
                            style: TextStyle(color: AppTheme.textGrey),
                          ),
                        ),
                      ),
                    )
                  : SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildProductCard(_produk[index]),
                        childCount: _produk.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.73,
                          ),
                    ),
            ),
            if (_hampers.isNotEmpty) ...[
              SliverToBoxAdapter(child: _buildHampersHeader()),
              SliverToBoxAdapter(child: _buildHampersList()),
            ],
          ],
        ),
      ),
      bottomNavigationBar: _buildContactButton(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 4, 20, 8),
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
            'Detail Toko',
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

  Widget _buildStoreIntroduction() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 0, 19, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: AspectRatio(
              aspectRatio: 1.18,
              child: Image.asset(
                widget.gambar,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _imagePlaceholder(),
              ),
            ),
          ),
          const SizedBox(height: 17),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: const [
              _InfoBadge(
                label: 'Produsen Tempe Higienis Sejak 1988',
                color: Color(0xFFD8E9C9),
                textColor: Color(0xFF536B45),
              ),
              _InfoBadge(
                label: 'Keluarga Pengrajin Sanan Asli',
                color: Color(0xFFF0E8E2),
                textColor: Color(0xFF6C5143),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.nama,
            style: const TextStyle(
              fontSize: 25,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            widget.deskripsi,
            style: const TextStyle(
              fontSize: 14,
              height: 1.55,
              color: AppTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF1EC),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            _informationRow(
              icon: Icons.location_on_outlined,
              title: 'ALAMAT LENGKAP',
              content: widget.alamat,
            ),
            const SizedBox(height: 17),
            _informationRow(
              icon: Icons.access_time,
              title: 'JAM BUKA',
              content: 'Senin – Minggu: ${widget.jamBuka}',
              subtitle: 'Buka Hari Ini',
              iconBackground: const Color(0xFFD7E9C9),
            ),
            const SizedBox(height: 17),
            _informationRow(
              icon: Icons.call_outlined,
              title: 'KONTAK LANGSUNG',
              content: '+${widget.nomorWhatsApp}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _informationRow({
    required IconData icon,
    required String title,
    required String content,
    String? subtitle,
    Color iconBackground = const Color(0xFFEDE5E0),
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconBackground,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 19, color: const Color(0xFF62402D)),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textGrey,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: AppTheme.textDark,
                ),
              ),
              if (subtitle != null)
                Text(
                  '• $subtitle',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF607C4A),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 32, 19, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lokasi Sentra Produksi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
              Text(
                'Akses Mudah',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF61744E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/kampung_sanan.jpg',
                  width: double.infinity,
                  height: 155,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => _imagePlaceholder(height: 155),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(
                    widget.nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 43,
            child: ElevatedButton.icon(
              onPressed: _bukaPeta,
              icon: const Icon(Icons.directions_outlined, size: 19),
              label: const Text('Buka Petunjuk Arah (Google Maps)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCatalogHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(19, 34, 19, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Katalog Produk & Harga',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Daftar produk langsung dari etalase toko',
            style: TextStyle(fontSize: 13, color: AppTheme.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    const categories = [
      'Semua',
      'Original',
      'Pedas',
      'Keju',
      'Barbeque',
      'Balado',
    ];
    return SizedBox(
      height: 55,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(19, 12, 19, 5),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = category == _kategoriAktif;
          return ChoiceChip(
            label: Text(category),
            selected: selected,
            showCheckmark: false,
            onSelected: (_) => setState(() => _kategoriAktif = category),
            labelStyle: TextStyle(
              fontSize: 11,
              color: selected ? Colors.white : AppTheme.textDark,
            ),
            backgroundColor: const Color(0xFFF0E8E2),
            selectedColor: AppTheme.primary,
            side: BorderSide.none,
          );
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 9,
            offset: Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _imagePlaceholder(),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.ukuran,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppTheme.textGrey,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.25,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    product.variant,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppTheme.textGrey,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product.price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHampersHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(19, 16, 19, 0),
      child: Text(
        'Paket Hampers',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppTheme.textDark,
        ),
      ),
    );
  }

  Widget _buildHampersList() {
    return SizedBox(
      height: 250,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(19, 8, 19, 0),
        scrollDirection: Axis.horizontal,
        children: _hampers
            .expand((card) => [card, const SizedBox(width: 12)])
            .toList(),
      ),
    );
  }

  Widget _buildContactButton() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(19, 10, 19, 8),
        decoration: const BoxDecoration(
          color: AppTheme.background,
          boxShadow: [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 12,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 47,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _hubungiToko,
                icon: const Icon(Icons.chat_outlined, size: 21),
                label: const Text(
                  'Hubungi Toko via WhatsApp',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF20CA68),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Tanya stok, varian, dan pemesanan langsung ke pemilik toko',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: AppTheme.textGrey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder({double? height}) {
    return Container(
      height: height,
      color: const Color(0xFFF3EEE9),
      alignment: Alignment.center,
      child: const Icon(
        Icons.storefront_outlined,
        color: Color(0xFFB7ADA5),
        size: 36,
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const _InfoBadge({
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
