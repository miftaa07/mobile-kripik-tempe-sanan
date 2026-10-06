import 'package:flutter/material.dart';

class HampersCard extends StatelessWidget {
  final String image;
  final String name;
  final String store;
  final String description;
  final String price;

  const HampersCard({
    super.key,
    required this.image,
    required this.name,
    required this.store,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 169,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE8DED5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.55,
              child: image.isEmpty
                  ? Container(
                      color: const Color(0xFFF3EEE9),
                      child: const Icon(
                        Icons.image_outlined,
                        color: Color(0xFFB7ADA5),
                        size: 35,
                      ),
                    )
                  : Image.asset(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          color: const Color(0xFFF3EEE9),
                          child: const Icon(
                            Icons.image_outlined,
                            color: Color(0xFFB7ADA5),
                            size: 35,
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    store,
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: Color(0xFF9B918A),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: Color(0xFF766E68),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF352B25),
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
}