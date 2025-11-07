import 'base_viewmodel.dart';
import '../repositories/queen_repository.dart';
import '../repositories/location_repository.dart';
import '../models/goth_queen.dart';
import '../models/location.dart';

/// ViewModel for the main game screen (VN interface)
class GameViewModel extends BaseViewModel {
  final QueenRepository _queenRepository;
  final LocationRepository _locationRepository;

  GothQueen? _currentQueen;
  Location? _currentLocation;
  final List<String> _storyText = [];
  String _playerInput = '';

  GameViewModel({
    QueenRepository? queenRepository,
    LocationRepository? locationRepository,
  })  : _queenRepository = queenRepository ?? MockQueenRepository(),
        _locationRepository = locationRepository ?? MockLocationRepository();

  GothQueen? get currentQueen => _currentQueen;
  Location? get currentLocation => _currentLocation;
  List<String> get storyText => List.unmodifiable(_storyText);
  String get playerInput => _playerInput;

  /// Initialize the game
  Future<void> initialize() async {
    await runBusyFuture(() async {
      // Load initial location and queen
      final locations = await _locationRepository.getAllLocations();
      _currentLocation = locations.isNotEmpty ? locations.first : null;

      if (_currentLocation != null) {
        final queens = await _queenRepository.getAllQueens();
        _currentQueen = queens.isNotEmpty ? queens.first : null;
      }

      // Add initial story text
      if (_currentLocation != null) {
        _addStoryText(
            'You find yourself in ${_currentLocation!.name}. ${_currentLocation!.description}');
        _addStoryText(_currentLocation!.atmosphere);
      }

      if (_currentQueen != null) {
        _addStoryText(
            'You notice ${_currentQueen!.name}. ${_currentQueen!.description}');
      }
    });
  }

  /// Update player input
  void updatePlayerInput(String input) {
    _playerInput = input;
    notifyListeners();
  }

  /// Process player's text command
  Future<void> processPlayerInput() async {
    if (_playerInput.trim().isEmpty) return;

    final input = _playerInput.trim();
    _addStoryText('> $input');

    // Clear input
    _playerInput = '';

    await runBusyFuture(() async {
      // TODO: Implement actual game logic
      // For now, just echo responses based on simple keywords

      if (input.toLowerCase().contains('talk') ||
          input.toLowerCase().contains('speak')) {
        if (_currentQueen != null) {
          _addStoryText(
              '${_currentQueen!.name} regards you with ${_currentQueen!.stats.mood > 0.5 ? "mild interest" : "cold indifference"}.');
          if (_currentQueen!.isPoet) {
            _addStoryText(
                '"The void whispers secrets to those who dare to listen..."');
          }
        }
      } else if (input.toLowerCase().contains('look') ||
          input.toLowerCase().contains('examine')) {
        if (_currentLocation != null) {
          _addStoryText(_currentLocation!.atmosphere);
        }
      } else if (input.toLowerCase().contains('stats') ||
          input.toLowerCase().contains('status')) {
        if (_currentQueen != null) {
          _addStoryText(
              'Mood: ${(_currentQueen!.stats.mood * 100).toStringAsFixed(0)}%, '
              'Friendship: ${(_currentQueen!.stats.friendship * 100).toStringAsFixed(0)}%');
        }
      } else {
        _addStoryText('Nothing happens. The silence is deafening.');
      }
    });
  }

  /// Navigate to a different location
  Future<void> navigateToLocation(String locationId) async {
    await runBusyFuture(() async {
      final location = await _locationRepository.getLocationById(locationId);
      if (location != null) {
        _currentLocation = location;
        _addStoryText('You arrive at ${location.name}.');
        _addStoryText(location.atmosphere);

        // Check for queens at this location
        final queens =
            await _queenRepository.getQueensAtLocation(locationId);
        if (queens.isNotEmpty) {
          _currentQueen = queens.first;
          _addStoryText('You see ${_currentQueen!.name} here.');
        }
      }
    });
  }

  /// Add text to the story log
  void _addStoryText(String text) {
    _storyText.add(text);
    notifyListeners();
  }

  /// Clear the story text
  void clearStory() {
    _storyText.clear();
    notifyListeners();
  }
}
