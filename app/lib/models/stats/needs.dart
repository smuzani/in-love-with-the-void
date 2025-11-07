/// Represents the needs system for a Goth Queen
/// Each need affects mood and behavior
class Needs {
  /// Life feels in tune with her void. Astrology or otherwise
  final double alignment;

  /// Deep, meaningful conversations. Small talk drains her
  final double intellectual;

  /// The desire to be alone
  final double solitude;

  /// The desire to not be alone
  final double social;

  /// Beauty, gloom, solitude, music
  final double aesthetic;

  /// Admiration from others, self-value. Dump stat.
  final double validation;

  /// Coffee dependency
  final double caffeine;

  /// Alcohol level
  final double alcohol;

  /// Nicotine dependency
  final double nicotine;

  const Needs({
    this.alignment = 0.5,
    this.intellectual = 0.5,
    this.solitude = 0.5,
    this.social = 0.5,
    this.aesthetic = 0.5,
    this.validation = 0.5,
    this.caffeine = 0.5,
    this.alcohol = 0.5,
    this.nicotine = 0.5,
  });

  /// Calculate the sum of all needs (used for mood calculation)
  double get sum =>
      alignment +
      intellectual +
      solitude +
      social +
      aesthetic +
      validation +
      caffeine +
      alcohol +
      nicotine;

  /// Create a copy with updated values
  Needs copyWith({
    double? alignment,
    double? intellectual,
    double? solitude,
    double? social,
    double? aesthetic,
    double? validation,
    double? caffeine,
    double? alcohol,
    double? nicotine,
  }) {
    return Needs(
      alignment: alignment ?? this.alignment,
      intellectual: intellectual ?? this.intellectual,
      solitude: solitude ?? this.solitude,
      social: social ?? this.social,
      aesthetic: aesthetic ?? this.aesthetic,
      validation: validation ?? this.validation,
      caffeine: caffeine ?? this.caffeine,
      alcohol: alcohol ?? this.alcohol,
      nicotine: nicotine ?? this.nicotine,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alignment': alignment,
      'intellectual': intellectual,
      'solitude': solitude,
      'social': social,
      'aesthetic': aesthetic,
      'validation': validation,
      'caffeine': caffeine,
      'alcohol': alcohol,
      'nicotine': nicotine,
    };
  }

  factory Needs.fromJson(Map<String, dynamic> json) {
    return Needs(
      alignment: (json['alignment'] as num?)?.toDouble() ?? 0.5,
      intellectual: (json['intellectual'] as num?)?.toDouble() ?? 0.5,
      solitude: (json['solitude'] as num?)?.toDouble() ?? 0.5,
      social: (json['social'] as num?)?.toDouble() ?? 0.5,
      aesthetic: (json['aesthetic'] as num?)?.toDouble() ?? 0.5,
      validation: (json['validation'] as num?)?.toDouble() ?? 0.5,
      caffeine: (json['caffeine'] as num?)?.toDouble() ?? 0.5,
      alcohol: (json['alcohol'] as num?)?.toDouble() ?? 0.5,
      nicotine: (json['nicotine'] as num?)?.toDouble() ?? 0.5,
    );
  }
}
