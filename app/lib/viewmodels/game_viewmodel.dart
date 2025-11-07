import 'base_viewmodel.dart';
import '../repositories/queen_repository.dart';
import '../repositories/location_repository.dart';
import '../models/goth_queen.dart';
import '../models/location.dart';
import '../services/claude_service.dart';

/// ViewModel for the main game screen (VN interface)
class GameViewModel extends BaseViewModel {
  final QueenRepository _queenRepository;
  final LocationRepository _locationRepository;
  final ClaudeService _claudeService;

  GothQueen? _currentQueen;
  Location? _currentLocation;
  final List<String> _storyText = [];
  String _playerInput = '';
  final List<Map<String, String>> _conversationHistory = [];

  GameViewModel({
    QueenRepository? queenRepository,
    LocationRepository? locationRepository,
    ClaudeService? claudeService,
  }) : _queenRepository = queenRepository ?? MockQueenRepository(),
       _locationRepository = locationRepository ?? MockLocationRepository(),
       _claudeService = claudeService ?? ClaudeService();

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
          'You find yourself in ${_currentLocation!.name}. ${_currentLocation!.description}',
        );
        _addStoryText(_currentLocation!.atmosphere);
      }

      if (_currentQueen != null) {
        _addStoryText(
          'You notice ${_currentQueen!.name}. ${_currentQueen!.description}',
        );
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
      try {
        // Build system prompt with game context
        final systemPrompt = _buildSystemPrompt();

        // Call Claude API
        final response = await _claudeService.sendMessage(
          userMessage: input,
          systemPrompt: systemPrompt,
          conversationHistory: _conversationHistory,
        );

        // Add to conversation history
        _conversationHistory.add({'role': 'user', 'content': input});
        _conversationHistory.add({'role': 'assistant', 'content': response});

        // Keep conversation history manageable (last 10 exchanges)
        if (_conversationHistory.length > 20) {
          _conversationHistory.removeRange(0, _conversationHistory.length - 20);
        }

        // Display response
        _addStoryText(response);
      } catch (e) {
        _addStoryText('The void remains silent. (Error: ${e.toString()})');
      }
    });
  }

  /// Build system prompt with current game state context
  String _buildSystemPrompt() {
    final buffer = StringBuffer();

    buffer.writeln(
      'You are the narrator for "In Love With The Void", a goth dating simulator visual novel.',
    );
    buffer.writeln(
      'Style: Dark, poetic, atmospheric. Think Bauhaus meets visual novels.',
    );
    buffer.writeln();

    // Current location
    if (_currentLocation != null) {
      buffer.writeln('CURRENT LOCATION: ${_currentLocation!.name}');
      buffer.writeln(_currentLocation!.description);
      buffer.writeln('Atmosphere: ${_currentLocation!.atmosphere}');
      buffer.writeln();
    }

    // Current queen
    if (_currentQueen != null) {
      buffer.writeln('CURRENT CHARACTER: ${_currentQueen!.name}');
      buffer.writeln(_currentQueen!.description);
      buffer.writeln();
      buffer.writeln('CHARACTER STATS:');
      buffer.writeln(
        'Mood: ${(_currentQueen!.stats.mood * 100).toStringAsFixed(0)}%',
      );
      buffer.writeln(
        'Friendship: ${(_currentQueen!.stats.friendship * 100).toStringAsFixed(0)}%',
      );

      if (_currentQueen!.isPoet)
        buffer.writeln('Trait: Poet (speaks in tongues)');
      if (_currentQueen!.isNihilist)
        buffer.writeln('Trait: Nihilist (mood always nil)');
      if (_currentQueen!.isSiren)
        buffer.writeln('Trait: Siren (has many followers)');
      buffer.writeln();
    }

    buffer.writeln('INSTRUCTIONS:');
    buffer.writeln('- Respond to player actions in 2-4 sentences maximum');
    buffer.writeln('- Be evocative but concise');
    buffer.writeln('- Match the dark, romantic, goth aesthetic');
    buffer.writeln(
      '- Queens are not easy - they are mysterious, aloof, powerful',
    );
    buffer.writeln(
      '- Describe what happens, what characters say/do in response',
    );

    return buffer.toString();
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
        final queens = await _queenRepository.getQueensAtLocation(locationId);
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
