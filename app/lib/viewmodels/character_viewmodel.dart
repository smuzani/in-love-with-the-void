import 'base_viewmodel.dart';
import '../repositories/queen_repository.dart';
import '../models/goth_queen.dart';
import '../models/traits.dart';

/// ViewModel for the character profile screen
class CharacterViewModel extends BaseViewModel {
  final QueenRepository _queenRepository;

  GothQueen? _queen;

  CharacterViewModel({QueenRepository? queenRepository})
      : _queenRepository = queenRepository ?? MockQueenRepository();

  GothQueen? get queen => _queen;

  /// Load a queen by ID
  Future<void> loadQueen(String queenId) async {
    await runBusyFuture(() async {
      _queen = await _queenRepository.getQueenById(queenId);
    });
  }

  /// Update queen's stats
  Future<void> updateQueen(GothQueen updatedQueen) async {
    await runBusyFuture(() async {
      await _queenRepository.updateQueen(updatedQueen);
      _queen = updatedQueen;
    });
  }

  /// Get formatted trait list
  String get traitsText {
    if (_queen == null || _queen!.traits.isEmpty) {
      return 'No special traits';
    }
    return _queen!.traits.map((t) => t.displayName).join(', ');
  }

  /// Get dominant skill
  String get dominantSkill {
    if (_queen == null) return 'Unknown';
    return _queen!.skills.dominantSkill;
  }
}
