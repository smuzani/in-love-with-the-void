/// Personality traits that define a Goth Queen's behavior
enum Trait {
  /// Mood is always nil
  nihilist,

  /// Reliant on caffeine in the day
  nocturnal,

  /// Speaks in tongues
  poet,

  /// Has plenty of followers, in the digital world or otherwise
  siren,

  /// Treats you poorly and you will like it
  bitch,

  /// The abyss stares at her
  voidTouched,

  /// Gets prophetic dreams
  oracle,
}

extension TraitExtension on Trait {
  String get displayName {
    switch (this) {
      case Trait.nihilist:
        return 'Nihilist';
      case Trait.nocturnal:
        return 'Nocturnal';
      case Trait.poet:
        return 'Poet';
      case Trait.siren:
        return 'Siren';
      case Trait.bitch:
        return 'Bitch';
      case Trait.voidTouched:
        return 'Void-touched';
      case Trait.oracle:
        return 'Oracle';
    }
  }

  String get description {
    switch (this) {
      case Trait.nihilist:
        return 'Mood is always nil';
      case Trait.nocturnal:
        return 'Reliant on caffeine in the day';
      case Trait.poet:
        return 'Speaks in tongues';
      case Trait.siren:
        return 'Has plenty of followers, in the digital world or otherwise';
      case Trait.bitch:
        return 'Treats you poorly and you will like it';
      case Trait.voidTouched:
        return 'The abyss stares at her';
      case Trait.oracle:
        return 'Gets prophetic dreams';
    }
  }

  String toJson() => name;

  static Trait fromJson(String json) {
    return Trait.values.firstWhere((trait) => trait.name == json);
  }
}
