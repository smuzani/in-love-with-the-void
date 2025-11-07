import 'needs.dart';

/// Core stats for a Goth Queen character
class CharacterStats {
  /// Sum of needs. Goth queens are queens whether happy or sad,
  /// but it governs their behavior
  final double mood;

  /// Mood with other factors. Breakdowns are always dangerous and beautiful
  final double sanity;

  /// How much she likes the PC (Player Character)
  final double friendship;

  const CharacterStats({
    this.mood = 0.5,
    this.sanity = 0.5,
    this.friendship = 0.0,
  });

  /// Calculate mood from needs
  factory CharacterStats.fromNeeds(
    Needs needs, {
    double? sanity,
    double? friendship,
  }) {
    // Mood is sum of needs normalized to 0-1 range
    final normalizedMood = needs.sum / 9.0; // 9 needs total

    return CharacterStats(
      mood: normalizedMood.clamp(0.0, 1.0),
      sanity: sanity ?? 0.5,
      friendship: friendship ?? 0.0,
    );
  }

  CharacterStats copyWith({
    double? mood,
    double? sanity,
    double? friendship,
  }) {
    return CharacterStats(
      mood: mood ?? this.mood,
      sanity: sanity ?? this.sanity,
      friendship: friendship ?? this.friendship,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
      'sanity': sanity,
      'friendship': friendship,
    };
  }

  factory CharacterStats.fromJson(Map<String, dynamic> json) {
    return CharacterStats(
      mood: (json['mood'] as num?)?.toDouble() ?? 0.5,
      sanity: (json['sanity'] as num?)?.toDouble() ?? 0.5,
      friendship: (json['friendship'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Check if character is in danger of breakdown
  bool get isDangerouslyLowSanity => sanity < 0.2;

  /// Check if character is in good mood
  bool get isHappy => mood > 0.6;

  /// Check if character considers PC a friend
  bool get isFriendly => friendship > 0.5;
}
