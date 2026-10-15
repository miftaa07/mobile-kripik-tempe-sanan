import 'package:flutter/material.dart';

import '../bantu_memilih/bantu_memilih_screen.dart';
import '../../theme/app_theme.dart';
import '../../widgets/hampers_card.dart';
import '../../widgets/product_card.dart';
import '../../widgets/toko_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _submittedQuery = '';

  static const List<_HomeSearchItem> _searchItems = [
    _HomeSearchItem(
      title: 'Kripik Tempe Original',
      subtitle: 'Toko Sanan Jaya',
      category: 'Original',
      price: 'Rp 10.000',
      image: 'assets/images/tempe_original.jpg',
    ),
    _HomeSearchItem(
      title: 'Kripik Tempe BBQ',
      subtitle: 'Toko Bu Susi',
      category: 'BBQ',
      price: 'Rp 10.000',
      image: 'assets/images/tempe_bbq.jpg',
    ),
    _HomeSearchItem(
      title: 'Kripik Tempe Pedas',
      subtitle: 'Toko Pak Rudi',
      category: 'Pedas',
      price: 'Rp 10.000',
      image: 'assets/images/tempe_original.jpg',
    ),
    _HomeSearchItem(
      title: 'Hampers Spesial Sanan',
      subtitle: 'Toko Sanan Jaya · Isi 4 varian keripik tempe',
      category: 'Hampers',
      price: 'Rp 50.000',
      image: 'assets/images/hampers_sanan.jpg',
    ),
    _HomeSearchItem(
      title: 'Hampers Keluarga',
      subtitle: 'Toko Bu Susi · Isi 5 varian keripik tempe',
      category: 'Hampers',
      price: 'Rp 75.000',
      image: 'assets/images/hampers_keluarga.jpg',
    ),
    _HomeSearchItem(
      title: 'Toko Sanan Jaya',
      subtitle: 'Jl. Sanan No. 12, Malang',
      category: 'Toko',
      image: 'assets/images/toko_rohani.jpg',
    ),
    _HomeSearchItem(
      title: 'Toko Ar - Ridlo',
      subtitle: 'Jl. Sanan No. 28, Malang',
      category: 'Toko',
      image: 'assets/images/toko_ar-ridlo.jpg',
    ),
    _HomeSearchItem(
      title: 'Kenali Kampung Sanan',
      subtitle: 'Kawasan yang dikenal sebagai sentra industri keripik tempe di Malang.',
      category: 'Informasi',
      image: 'assets/images/kampung_sanan.jpg',
    ),
    _HomeSearchItem(
      title: 'Asisten Cerdas Sanan',
      subtitle: 'Temukan toko atau produk keripik tempe sesuai kebutuhanmu.',
      category: 'Informasi',
      image: 'assets/images/robot.png',
    ),
  ];

  List<_HomeSearchItem> get _searchResults {
    final query = _submittedQuery.trim().toLowerCase();
    if (query.isEmpty) return const [];

    return _searchItems.where((item) {
      return '${item.title} ${item.subtitle} ${item.category} '
              '${item.price ?? ''} Keripik Tempe'
          .toLowerCase()
          .contains(query);
    }).toList();
  }

  void _submitSearch([String? value]) {
    final query = (value ?? _searchController.text).trim();
    setState(() {
      _submittedQuery = query;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(21, 12, 21, 0),
            sliver: SliverToBoxAdapter(child: _buildHeader()),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(21, 12, 21, 0),
            sliver: SliverToBoxAdapter(child: _buildSearch()),
          ),
          if (_submittedQuery.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(21, 22, 21, 24),
              sliver: SliverToBoxAdapter(child: _buildSearchResults()),
            ),
          ] else ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(21, 22, 21, 0),
              sliver: SliverToBoxAdapter(child: _buildAssistantCard(context)),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(21, 16, 0, 0),
              sliver: SliverToBoxAdapter(
                child: _buildSectionHeader('Produk Terbaru'),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 214,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(21, 12, 21, 0),
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ProductCard(
                      image: 'assets/images/tempe_original.jpg',
                      name: 'Kripik Tempe Original',
                      store: 'Toko Sanan Jaya',
                      variant: 'Original',
                      price: 'Rp 10.000',
                    ),
                    SizedBox(width: 10),
                    ProductCard(
                      image: 'assets/images/tempe_bbq.jpg',
                      name: 'Kripik Tempe BBQ',
                      store: 'Toko Bu Susi',
                      variant: 'BBQ',
                      price: 'Rp 10.000',
                    ),
                    SizedBox(width: 10),
                    ProductCard(
                      image: 'assets/images/tempe_original.jpg',
                      name: 'Kripik Tempe Pedas',
                      store: 'Toko Pak Rudi',
                      variant: 'Pedas',
                      price: 'Rp 10.000',
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(21, 12, 0, 0),
              sliver: SliverToBoxAdapter(
                child: _buildSectionHeader('Paket Hampers'),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 235,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(21, 12, 21, 0),
                  scrollDirection: Axis.horizontal,
                  children: const [
                    HampersCard(
                      image: 'assets/images/hampers_sanan.jpg',
                      name: 'Hampers Spesial Sanan',
                      store: 'Toko Sanan Jaya',
                      description: 'Isi 4 varian keripik tempe',
                      price: 'Rp 50.000',
                    ),
                    SizedBox(width: 12),
                    HampersCard(
                      image: 'assets/images/hampers_keluarga.jpg',
                      name: 'Hampers Keluarga',
                      store: 'Toko Bu Susi',
                      description: 'Isi 5 varian keripik tempe',
                      price: 'Rp 75.000',
                    ),
                    SizedBox(width: 12),
                    HampersCard(
                      image: 'assets/images/hampers_sanan.jpg',
                      name: 'Hampers Spesial Sanan',
                      store: 'Toko Sanan Jaya',
                      description: 'Isi 4 varian keripik tempe',
                      price: 'Rp 50.000',
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(21, 11, 0, 0),
              sliver: SliverToBoxAdapter(
                child: _buildSectionHeader('Temukan Toko di Sanan'),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 263,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(21, 12, 21, 0),
                  scrollDirection: Axis.horizontal,
                  children: const [
                    TokoCard(
                      image: 'assets/images/toko_rohani.jpg',
                      name: 'Toko Sanan Jaya',
                      address: 'Jl. Sanan No. 12, Malang',
                      description: 'Toko legendaris dengan berbagai varian keripik tempe.',
                    ),
                    SizedBox(width: 12),
                    TokoCard(
                      image: 'assets/images/toko_ar-ridlo.jpg',
                      name: 'Toko Ar - Ridlo',
                      address: 'Jl. Sanan No. 28, Malang',
                      description:
                          'Terkenal dengan rasa khas dan kualitas terjaga.',
                    ),
                    SizedBox(width: 12),
                    TokoCard(
                      image: 'assets/images/toko_rohani.jpg',
                      name: 'Toko Sanan Jaya',
                      address: 'Jl. Sanan No. 12, Malang',
                      description: 'Toko legendaris dengan berbagai varian keripik tempe.',
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(21, 18, 21, 20),
              sliver: SliverToBoxAdapter(child: _buildKnowledgeCard()),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 49,
      child: Row(
        children: [
          const Icon(Icons.eco_outlined, size: 24, color: AppTheme.primary),
          const SizedBox(width: 9),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kampung Keripik Tempe',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF67432F),
                  ),
                ),
                Text(
                  'Sanan',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 27,
                    height: 0.95,
                    fontStyle: FontStyle.italic,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      height: 43,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5DDD6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.search,
        onSubmitted: _submitSearch,
        onChanged: (value) {
          if (_submittedQuery.isNotEmpty) {
            setState(() {
              _submittedQuery = '';
            });
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          prefixIcon: IconButton(
            onPressed: _submitSearch,
            icon: const Icon(Icons.search, size: 20, color: Color(0xFF897E77)),
            tooltip: 'Cari',
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 43,
            minHeight: 43,
          ),
          hintText: 'Cari toko, produk, atau informasi...',
          hintStyle: const TextStyle(fontSize: 11.5, color: Color(0xFFB2AAA5)),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    final results = _searchResults;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final cardAspectRatio = screenWidth < 360
        ? 0.48
        : screenWidth < 400
        ? 0.55
        : 0.63;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          results.isEmpty
              ? 'Tidak ada hasil untuk "$_submittedQuery"'
              : 'Hasil pencarian (${results.length})',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D2723),
          ),
        ),
        if (results.isNotEmpty) ...[
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: results.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 13,
              mainAxisSpacing: 13,
              childAspectRatio: cardAspectRatio,
            ),
            itemBuilder: (context, index) {
              final item = results[index];
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x12000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: constraints.maxWidth * 0.8,
                          child: Image.asset(
                            item.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFFF3EFEB),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_outlined,
                                  size: 32,
                                  color: Color(0xFFB8AEA6),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 11),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.2,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF211D1A),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  item.subtitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF9B9DA7),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF4ED),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Text(
                                    item.category,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF87421F),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                if (item.price case final price?)
                                  Text(
                                    price,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF4B2D1E),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildAssistantCard(BuildContext context) {
    return Container(
      height: 187,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFF8E6D3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            right: -53,
            child: Image.asset(
              'assets/images/robot.png',
              width: 250,
              height: 167,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(27, 13, 112, 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE7D6C6)),
                  ),
                  child: const Text(
                    '✦  Asisten Cerdas Sanan',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Bingung pilih toko?',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF432A1D),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Temukan toko atau produk keripik\n'
                  'tempe yang sesuai dengan\n'
                  'kebutuhanmu.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.5,
                    color: Color(0xFF76665D),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 33,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => BantuMemilihScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '✦ Bantu Saya Memilih',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 21),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D2723),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Lihat Semua ›',
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKnowledgeCard() {
    return Container(
      height: 153,
      decoration: BoxDecoration(
        color: const Color(0xFFF4E3CF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(17, 15, 10, 12),
        child: Row(
          children: [
            const Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kenali Kampung Sanan',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3C3028),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Kenal lebih dekat dengan Kampung Sanan, '
                    'kawasan yang dikenal sebagai sentra industri '
                    'keripik tempe di Malang.',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 9,
                      height: 1.4,
                      color: Color(0xFF71655D),
                    ),
                  ),
                  Spacer(),
                  _MoreButton(),
                ],
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/kampung_sanan.jpg',
                  height: 110,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeSearchItem {
  final String title;
  final String subtitle;
  final String category;
  final String image;
  final String? price;

  const _HomeSearchItem({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.image,
    this.price,
  });
}

class _MoreButton extends StatelessWidget {
  const _MoreButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Text(
        'Selengkapnya ›',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}
