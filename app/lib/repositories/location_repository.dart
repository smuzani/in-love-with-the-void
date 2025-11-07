import '../models/location.dart';

/// Repository for managing location data
///
/// This is currently a mock implementation. In the future, locations
/// can be dynamically generated via LLM.
abstract class LocationRepository {
  /// Get all available locations in Nocturne Square
  Future<List<Location>> getAllLocations();

  /// Get a specific location by ID
  Future<Location?> getLocationById(String id);

  /// Generate a new random location (will use LLM in the future)
  Future<Location> generateLocation();
}

/// Mock implementation of LocationRepository for development
class MockLocationRepository implements LocationRepository {
  final List<Location> _locations = Location.getSampleLocations();

  @override
  Future<List<Location>> getAllLocations() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_locations);
  }

  @override
  Future<Location?> getLocationById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _locations.firstWhere((loc) => loc.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Location> generateLocation() async {
    // TODO: Replace with LLM generation via Supabase
    await Future.delayed(const Duration(milliseconds: 1000));

    // For now, return a random sample location
    return _locations.first;
  }
}
