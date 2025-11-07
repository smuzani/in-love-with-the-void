import 'base_viewmodel.dart';
import '../repositories/location_repository.dart';
import '../models/location.dart';

/// ViewModel for the home/main menu screen
class HomeViewModel extends BaseViewModel {
  final LocationRepository _locationRepository;

  List<Location> _locations = [];

  HomeViewModel({LocationRepository? locationRepository})
    : _locationRepository = locationRepository ?? MockLocationRepository();

  List<Location> get locations => List.unmodifiable(_locations);

  /// Initialize the home screen
  Future<void> initialize() async {
    await runBusyFuture(() async {
      _locations = await _locationRepository.getAllLocations();
    });
  }

  /// Navigate to a specific location (returns location ID)
  String? navigateToLocation(String locationId) {
    final location = _locations
        .where((loc) => loc.id == locationId)
        .firstOrNull;
    if (location != null) {
      return location.id;
    }
    return null;
  }
}
