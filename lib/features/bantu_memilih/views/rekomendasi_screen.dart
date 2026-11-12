import 'package:flutter/material.dart';

import '../../../core/di/app_dependencies.dart';
import '../../../core/theme/app_theme.dart';
import '../../toko/models/product.dart';
import '../models/product_preferences.dart';
import '../viewmodels/rekomendasi_view_model.dart';

const _brown = AppTheme.primary;
const _cream = Color(0xFFFBF6EE);
const _card = Color(0xFFF6EDE0);

class RekomendasiScreen extends StatelessWidget {
  final ProductPreferences preferences;
  final RekomendasiViewModel _viewModel;

  RekomendasiScreen({
    super.key,
    required this.preferences,
    RekomendasiViewModel? viewModel,
    AppDependencies? dependencies,
  }) : _viewModel =
           viewModel ??
           RekomendasiViewModel(
             (dependencies ?? AppDependencies.instance)
                 .recommendationRepository,
             preferences,
           );

  @override
  Widget build(BuildContext context) {
    final hasil = _viewModel.recommendations;
    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        backgroundColor: _cream,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Rekomendasi untukmu',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasil.isEmpty
                      ? 'Belum ada yang cocok'
                      : 'Ini rekomendasi terbaik untukmu!',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasil.isEmpty
                      ? 'Coba ubah preferensimu supaya ada hasil yang sesuai.'
                      : 'Berdasarkan pilihanmu, berikut produk yang paling sesuai.',
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < hasil.length; i++)
            _produkCard(hasil[i].product, hasil[i].reasons, i == 0),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  'Masih belum pas?',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _brown,
                      side: const BorderSide(color: Colors.black12),
                      backgroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('Atur Ulang Preferensi'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _produkCard(Product p, List<String> alasan, bool terbaik) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _card,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 90,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: p.image.isEmpty
              ? const Icon(Icons.image_outlined, color: Colors.black38)
              : Image.asset(
                  p.image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.image_outlined, color: Colors.black38),
                ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (terbaik)
                const Text(
                  '★ Rekomendasi',
                  style: TextStyle(fontSize: 10, color: _brown),
                ),
              Text(
                p.store,
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
              Text(
                p.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              Text(
                p.price,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: _brown,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Karena ${alasan.join(', ')}',
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 34,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Lihat Toko',
                    style: TextStyle(fontSize: 12),
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
