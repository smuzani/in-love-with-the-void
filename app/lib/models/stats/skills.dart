/// Skills system for a Goth Queen
class Skills {
  /// The depth of introspection, capacity to monologue about pain and poetry
  final double gravitas;

  /// Fashion sense, design, etc
  final double aestheticism;

  /// Perfumes, soaps, dyes, poison
  final double alchemy;

  /// The ability to manipulate others to her bidding with seemingly little effort
  final double charisma;

  /// Lore, myth, grimoires, curses
  final double occult;

  /// Any kind of physical conflict
  final double combat;

  /// Ability to use digital shit
  final double tech;

  const Skills({
    this.gravitas = 0.5,
    this.aestheticism = 0.5,
    this.alchemy = 0.5,
    this.charisma = 0.5,
    this.occult = 0.5,
    this.combat = 0.5,
    this.tech = 0.5,
  });

  Skills copyWith({
    double? gravitas,
    double? aestheticism,
    double? alchemy,
    double? charisma,
    double? occult,
    double? combat,
    double? tech,
  }) {
    return Skills(
      gravitas: gravitas ?? this.gravitas,
      aestheticism: aestheticism ?? this.aestheticism,
      alchemy: alchemy ?? this.alchemy,
      charisma: charisma ?? this.charisma,
      occult: occult ?? this.occult,
      combat: combat ?? this.combat,
      tech: tech ?? this.tech,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gravitas': gravitas,
      'aestheticism': aestheticism,
      'alchemy': alchemy,
      'charisma': charisma,
      'occult': occult,
      'combat': combat,
      'tech': tech,
    };
  }

  factory Skills.fromJson(Map<String, dynamic> json) {
    return Skills(
      gravitas: (json['gravitas'] as num?)?.toDouble() ?? 0.5,
      aestheticism: (json['aestheticism'] as num?)?.toDouble() ?? 0.5,
      alchemy: (json['alchemy'] as num?)?.toDouble() ?? 0.5,
      charisma: (json['charisma'] as num?)?.toDouble() ?? 0.5,
      occult: (json['occult'] as num?)?.toDouble() ?? 0.5,
      combat: (json['combat'] as num?)?.toDouble() ?? 0.5,
      tech: (json['tech'] as num?)?.toDouble() ?? 0.5,
    );
  }

  /// Get the highest skill value
  double get highestSkill {
    return [gravitas, aestheticism, alchemy, charisma, occult, combat, tech]
        .reduce((a, b) => a > b ? a : b);
  }

  /// Get the name of the highest skill
  String get dominantSkill {
    final skills = {
      'gravitas': gravitas,
      'aestheticism': aestheticism,
      'alchemy': alchemy,
      'charisma': charisma,
      'occult': occult,
      'combat': combat,
      'tech': tech,
    };

    return skills.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }
}
