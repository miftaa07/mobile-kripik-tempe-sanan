import '../../../core/utils/external_link_launcher.dart';
import '../models/location_guide.dart';
import '../repositories/location_repository.dart';

class LocationViewModel {
  final LocationRepository _repository;
  final ExternalLinkLauncher _linkLauncher;

  const LocationViewModel(this._repository, this._linkLauncher);

  LocationGuide get guide => _repository.getGuide();

  Future<bool> openRoute() {
    final query = Uri.encodeComponent(guide.address);
    return _linkLauncher.open(
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$query'),
    );
  }
}
