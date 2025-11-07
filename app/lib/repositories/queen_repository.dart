import '../models/goth_queen.dart';

/// Repository for managing Goth Queen data
///
/// This is currently a mock implementation. In the future, this will
/// integrate with Supabase for LLM-generated queens and persistent data.
abstract class QueenRepository {
  /// Get all available queens
  Future<List<GothQueen>> getAllQueens();

  /// Get a specific queen by ID
  Future<GothQueen?> getQueenById(String id);

  /// Get queens at a specific location
  Future<List<GothQueen>> getQueensAtLocation(String locationId);

  /// Update a queen's state (needs, stats, etc.)
  Future<void> updateQueen(GothQueen queen);

  /// Generate a new random queen (will use LLM in the future)
  Future<GothQueen> generateQueen();
}

/// Mock implementation of QueenRepository for development
class MockQueenRepository implements QueenRepository {
  final List<GothQueen> _queens = [
    GothQueen.sample(),
  ];

  @override
  Future<List<GothQueen>> getAllQueens() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_queens);
  }

  @override
  Future<GothQueen?> getQueenById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _queens.firstWhere((q) => q.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<GothQueen>> getQueensAtLocation(String locationId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _queens.where((q) => q.currentLocation == locationId).toList();
  }

  @override
  Future<void> updateQueen(GothQueen queen) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _queens.indexWhere((q) => q.id == queen.id);
    if (index != -1) {
      _queens[index] = queen;
    }
  }

  @override
  Future<GothQueen> generateQueen() async {
    // TODO: Replace with LLM generation via Supabase
    await Future.delayed(const Duration(milliseconds: 1000));

    // For now, return a sample queen
    return GothQueen.sample();
  }
}
