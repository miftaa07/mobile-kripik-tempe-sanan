class TransportOption {
  final String title;
  final String duration;
  final String description;
  final bool byAir;

  const TransportOption({
    required this.title,
    required this.duration,
    required this.description,
    this.byAir = false,
  });
}

class LocationGuide {
  final String address;
  final String area;
  final List<TransportOption> transportOptions;

  const LocationGuide({
    required this.address,
    required this.area,
    required this.transportOptions,
  });
}
