import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/di/app_dependencies.dart';
import '../../../core/theme/app_theme.dart';
import '../models/toko.dart';
import '../viewmodels/toko_view_model.dart';
import 'toko_detail_screen.dart';

class TokoScreen extends StatefulWidget {
  final TokoViewModel? viewModel;
  final AppDependencies? dependencies;

  const TokoScreen({super.key, this.viewModel, this.dependencies});

  @override
  State<TokoScreen> createState() => _TokoScreenState();
}

class _TokoScreenState extends State<TokoScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final TokoViewModel _viewModel;
  late final bool _ownsViewModel;

  @override
  void initState() {
    super.initState();
    _ownsViewModel = widget.viewModel == null;
    _viewModel =
        widget.viewModel ??
        TokoViewModel(
          (widget.dependencies ?? AppDependencies.instance).tokoRepository,
        );
    _viewModel.addListener(_onViewModelChanged);
  }

  void _onViewModelChanged() {
    if (mounted) setState(() {});
  }

  void _onSearchChanged(String value) {
    _viewModel.search(value);
  }

  void _clearSearch() {
    _searchController.clear();
    _viewModel.clearSearch();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    if (_ownsViewModel) _viewModel.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final toko = _viewModel.filteredTokos;

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
                  ? Center(
                      child: Text(
                        _viewModel.searchError != null
                            ? 'Periksa kembali kata pencarian'
                            : 'Toko tidak ditemukan',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppTheme.textGrey),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      itemCount: toko.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'''[@;'"<>\\]''')),
            ],
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
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: _clearSearch,
                      icon: const Icon(Icons.close, size: 19),
                      tooltip: 'Hapus pencarian',
                    )
                  : null,
              errorText: _viewModel.searchError,
              filled: true,
              fillColor: const Color(0xFFF3F0EF),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(color: AppTheme.primary),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 58,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(27, 14, 20, 4),
        scrollDirection: Axis.horizontal,
        itemCount: TokoViewModel.categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = TokoViewModel.categories[index];
          final terpilih = item == _viewModel.activeCategory;

          return ChoiceChip(
            label: Text(item),
            selected: terpilih,
            showCheckmark: false,
            onSelected: (_) {
              _viewModel.selectCategory(item);
            },
            labelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: terpilih ? Colors.white : AppTheme.textDark,
            ),
            backgroundColor: Colors.white,
            selectedColor: AppTheme.primary,
            side: BorderSide(
              color: terpilih ? AppTheme.primary : const Color(0xFFE8D8CC),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoreCard(Toko toko) {
    void bukaDetail() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => TokoDetailScreen(
            nama: toko.nama,
            gambar: toko.gambar,
            alamat: toko.alamat,
            jamBuka: toko.jamBuka,
            deskripsi: 'Salah satu pelopor olahan keripik tempe renyah tanpa bahan pengawet di Sanan. Menggunakan kedelai pilihan dengan teknik peragian tradisional dan bumbu rempah alami khas Malang.',
            dependencies: widget.dependencies,
          ),
        ),
      );
    }

    return InkWell(
      onTap: bukaDetail,
      borderRadius: BorderRadius.circular(14),
      child: Container(
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
                      errorBuilder: (_, _, _) {
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
                      onPressed: bukaDetail,
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
