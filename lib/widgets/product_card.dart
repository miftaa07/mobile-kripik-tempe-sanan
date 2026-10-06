import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String store;
  final String variant;
  final String price;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.store,
    required this.variant,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 215,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: const Color(0xFFE6DDD5),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // IMAGE
            // =========================
            SizedBox(
              width: double.infinity,
              height: 104,
              child: _buildImage(),
            ),

            // =========================
            // PRODUCT INFORMATION
            // =========================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  8,
                  7,
                  8,
                  7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama produk
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3A302A),
                      ),
                    ),

                    const SizedBox(height: 3),

                    // Nama toko
                    Text(
                      store,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 8.5,
                        color: Color(0xFF8A7D74),
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Variant
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7EEE6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        variant,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 7.5,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Harga
                    Text(
                      price,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
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
      ),
    );
  }

  Widget _buildImage() {
    if (image.isEmpty) {
      return Container(
        color: const Color(0xFFF3EFEB),
        alignment: Alignment.center,
        child: const Icon(
          Icons.image_outlined,
          size: 29,
          color: Color(0xFFB8AEA6),
        ),
      );
    }

    return Image.asset(
      image,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: const Color(0xFFF3EFEB),
          alignment: Alignment.center,
          child: const Icon(
            Icons.image_outlined,
            size: 29,
            color: Color(0xFFB8AEA6),
          ),
        );
      },
    );
  }
}