class HomeSearchItem {
  final String title;
  final String subtitle;
  final String category;
  final String image;
  final String? price;

  const HomeSearchItem({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.image,
    this.price,
  });
}
