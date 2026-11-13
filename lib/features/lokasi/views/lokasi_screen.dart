import 'package:flutter/material.dart';

import '../../../core/di/app_dependencies.dart';
import '../../../core/theme/app_theme.dart';
import '../viewmodels/location_view_model.dart';

class LokasiScreen extends StatelessWidget {
  LokasiScreen({
    super.key,
    this.onBack,
    LocationViewModel? viewModel,
    AppDependencies? dependencies,
  }) : _viewModel =
           viewModel ??
           LocationViewModel(
             (dependencies ?? AppDependencies.instance).locationRepository,
             (dependencies ?? AppDependencies.instance).externalLinkLauncher,
           );

  final VoidCallback? onBack;
  final LocationViewModel _viewModel;

  Future<void> _bukaRute(BuildContext context) async {
    final berhasil = await _viewModel.openRoute();
    if (!berhasil && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka aplikasi peta.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              _buildAreaLabel(),
              _buildHero(),
              _buildLocationCard(),
              _buildDirectionsButton(context),
              _buildTransportGuide(),
              _buildVisitRecommendation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 20, 6),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.textDark,
            tooltip: 'Kembali',
          ),
          const SizedBox(width: 4),
          const Text(
            'Lokasi',
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaLabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 17,
            color: Color(0xFF60734C),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              _viewModel.guide.area,
              style: TextStyle(color: AppTheme.textGrey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      height: 145,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(17)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/kampung_sanan.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xD9000000)],
              ),
            ),
          ),
          const Positioned(
            left: 16,
            right: 12,
            bottom: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SENTRA INDUSTRI TEMPE & KERIPIK TEMPE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Jelajahi Untuk Menemukan Berbagai Toko',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 270, child: _NeighborhoodMap()),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _iconTile(Icons.place_outlined),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _Eyebrow('ALAMAT KAWASAN SENTRA'),
                          const SizedBox(height: 3),
                          Text(
                            _viewModel.guide.address,
                            style: const TextStyle(
                              color: AppTheme.textDark,
                              fontSize: 14,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _infoPill(
                        icon: Icons.directions_transit_outlined,
                        label: 'Dari Kotabaru',
                        value: '10 Menit (3.2 km)',
                      ),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: _infoPill(
                        icon: Icons.map_outlined,
                        label: 'Luas Kawasan',
                        value: '10+ Toko',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: SizedBox(
        height: 49,
        child: FilledButton.icon(
          onPressed: () => _bukaRute(context),
          icon: const Icon(Icons.directions_outlined, size: 20),
          label: const Text(
            'Buka Rute Menuju Kampung Sanan',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransportGuide() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Panduan Transportasi',
            style: TextStyle(
              color: AppTheme.textDark,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 9),
          for (
            var index = 0;
            index < _viewModel.guide.transportOptions.length;
            index++
          ) ...[
            _transportCard(
              icon: _viewModel.guide.transportOptions[index].byAir
                  ? Icons.flight
                  : Icons.directions_transit_outlined,
              title: _viewModel.guide.transportOptions[index].title,
              duration: _viewModel.guide.transportOptions[index].duration,
              description: _viewModel.guide.transportOptions[index].description,
            ),
            if (index < _viewModel.guide.transportOptions.length - 1)
              const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildVisitRecommendation() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF3E1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF586E48),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.access_time, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Eyebrow(
                  'REKOMENDASI WAKTU KUNJUNGAN',
                  color: Color(0xFF586E48),
                ),
                SizedBox(height: 3),
                Text(
                  'Pukul 08.00 – 16.00 WIB',
                  style: TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Waktu terbaik untuk melihat langsung aktivitas pengrajin menjemur kedelai dan memproduksi keripik tempe hangat yang masih segar dari penggorengan.',
                  style: TextStyle(
                    color: AppTheme.textGrey,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _iconTile(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFF4EEEA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppTheme.textDark, size: 20),
    );
  }

  static Widget _infoPill({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFFF6EFEB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF586E48), size: 19),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _transportCard({
    required IconData icon,
    required String title,
    required String duration,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFF4EEEA),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.textDark, size: 20),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: AppTheme.textDark,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: const TextStyle(
                        color: Color(0xFF586E48),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppTheme.textGrey,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text, {this.color = AppTheme.textGrey});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 9,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.25,
      ),
    );
  }
}

class _NeighborhoodMap extends StatelessWidget {
  const _NeighborhoodMap();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const CustomPaint(painter: _NeighborhoodMapPainter()),
        const Positioned(
          left: 18,
          top: 16,
          child: _MapTag(icon: Icons.circle, label: 'Gerbang Gapura Sanan'),
        ),
        const Positioned(
          left: 18,
          top: 88,
          child: Text(
            'SINGOSARI',
            style: TextStyle(
              color: Color(0xFF777C72),
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Positioned(
          left: 118,
          top: 145,
          child: Text(
            'Malang',
            style: TextStyle(
              color: Color(0xFF565B53),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Positioned(
          right: 20,
          top: 75,
          child: Text(
            'BLIMBING',
            style: TextStyle(
              color: Color(0xFF777C72),
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Positioned(
          left: 72,
          bottom: 57,
          child: Text(
            'Wagir',
            style: TextStyle(color: Color(0xFF777C72), fontSize: 9),
          ),
        ),
        const Positioned(
          right: 33,
          bottom: 88,
          child: Text(
            'TAMIAJENG',
            style: TextStyle(
              color: Color(0xFF777C72),
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Center(
          child: Icon(
            Icons.location_on,
            color: Color(0xFF9B4A22),
            size: 39,
            shadows: [Shadow(color: Colors.white, blurRadius: 5)],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 66,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xB9000000)],
              ),
            ),
          ),
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 12,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _MapTag(
                  icon: Icons.alt_route,
                  label: 'Poros Utama Jl. Sanan (Gang 1–15)',
                  dark: true,
                ),
                SizedBox(width: 6),
                _MapTag(label: 'Zona Wisata', dark: true),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MapTag extends StatelessWidget {
  const _MapTag({this.icon, required this.label, this.dark = false});

  final IconData? icon;
  final String label;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: dark ? const Color(0xB326211D) : const Color(0xF5FFFFFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 13,
              color: dark ? Colors.white : const Color(0xFF586E48),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: dark ? Colors.white : AppTheme.textDark,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _NeighborhoodMapPainter extends CustomPainter {
  const _NeighborhoodMapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(const Color(0xFFE9EEE4), BlendMode.srcOver);

    final parkPaint = Paint()..color = const Color(0xFFD8E6D0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.68, size.height * 0.08, 95, 55),
        const Radius.circular(20),
      ),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.07, size.height * 0.58, 70, 50),
        const Radius.circular(18),
      ),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.76, size.height * 0.57, 78, 42),
        const Radius.circular(16),
      ),
      parkPaint,
    );

    _drawRoad(
      canvas,
      size,
      Path()
        ..moveTo(-20, size.height * 0.19)
        ..cubicTo(
          size.width * 0.28,
          size.height * 0.30,
          size.width * 0.52,
          size.height * 0.11,
          size.width + 20,
          size.height * 0.25,
        ),
      12,
    );
    _drawRoad(
      canvas,
      size,
      Path()
        ..moveTo(size.width * 0.14, -10)
        ..cubicTo(
          size.width * 0.33,
          size.height * 0.25,
          size.width * 0.18,
          size.height * 0.62,
          size.width * 0.37,
          size.height + 10,
        ),
      10,
    );
    _drawRoad(
      canvas,
      size,
      Path()
        ..moveTo(size.width * 0.77, -10)
        ..cubicTo(
          size.width * 0.61,
          size.height * 0.25,
          size.width * 0.82,
          size.height * 0.58,
          size.width * 0.66,
          size.height + 10,
        ),
      9,
    );
    _drawRoad(
      canvas,
      size,
      Path()
        ..moveTo(-10, size.height * 0.78)
        ..cubicTo(
          size.width * 0.28,
          size.height * 0.65,
          size.width * 0.63,
          size.height * 0.91,
          size.width + 10,
          size.height * 0.72,
        ),
      8,
    );
    _drawRoad(
      canvas,
      size,
      Path()
        ..moveTo(size.width * 0.47, -10)
        ..cubicTo(
          size.width * 0.57,
          size.height * 0.28,
          size.width * 0.40,
          size.height * 0.68,
          size.width * 0.54,
          size.height + 10,
        ),
      6,
    );
  }

  void _drawRoad(Canvas canvas, Size size, Path path, double width) {
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFFAFAF6)
        ..strokeWidth = width
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFD7D5CD)
        ..strokeWidth = width * 0.22
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant _NeighborhoodMapPainter oldDelegate) => false;
}
