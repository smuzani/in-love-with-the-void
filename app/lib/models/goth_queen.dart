import 'stats/needs.dart';
import 'stats/character_stats.dart';
import 'stats/skills.dart';
import 'traits.dart';

/// A woman who reigns over her own darkness
///
/// Universal traits:
/// - Visually: black lace, eyeliner, leather, spikes, cold glamor
/// - Emotionally: fearless of death, detached to life, danger, a little femme fatale
/// - Socially: admired, feared, imitated
class GothQueen {
  final String id;
  final String name;
  final String description;

  /// Visual appearance description
  final String appearance;

  /// Current needs state
  final Needs needs;

  /// Core character stats
  final CharacterStats stats;

  /// Character skills
  final Skills skills;

  /// Personality traits
  final List<Trait> traits;

  /// Current location (if applicable)
  final String? currentLocation;

  const GothQueen({
    required this.id,
    required this.name,
    required this.description,
    required this.appearance,
    this.needs = const Needs(),
    this.stats = const CharacterStats(),
    this.skills = const Skills(),
    this.traits = const [],
    this.currentLocation,
  });

  GothQueen copyWith({
    String? id,
    String? name,
    String? description,
    String? appearance,
    Needs? needs,
    CharacterStats? stats,
    Skills? skills,
    List<Trait>? traits,
    String? currentLocation,
  }) {
    return GothQueen(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      appearance: appearance ?? this.appearance,
      needs: needs ?? this.needs,
      stats: stats ?? this.stats,
      skills: skills ?? this.skills,
      traits: traits ?? this.traits,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }

  /// Update stats based on current needs
  GothQueen updateStatsFromNeeds() {
    final updatedStats = CharacterStats.fromNeeds(
      needs,
      sanity: stats.sanity,
      friendship: stats.friendship,
    );

    return copyWith(stats: updatedStats);
  }

  /// Check if this queen has a specific trait
  bool hasTrait(Trait trait) => traits.contains(trait);

  /// Check if queen is a nihilist (mood always nil)
  bool get isNihilist => hasTrait(Trait.nihilist);

  /// Check if queen is nocturnal (caffeine dependent during day)
  bool get isNocturnal => hasTrait(Trait.nocturnal);

  /// Check if queen speaks poetically
  bool get isPoet => hasTrait(Trait.poet);

  /// Check if queen has many followers
  bool get isSiren => hasTrait(Trait.siren);

  /// Check if queen is deliberately mean
  bool get isBitch => hasTrait(Trait.bitch);

  /// Check if queen is touched by the void
  bool get isVoidTouched => hasTrait(Trait.voidTouched);

  /// Check if queen has prophetic dreams
  bool get isOracle => hasTrait(Trait.oracle);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'appearance': appearance,
      'needs': needs.toJson(),
      'stats': stats.toJson(),
      'skills': skills.toJson(),
      'traits': traits.map((t) => t.toJson()).toList(),
      'currentLocation': currentLocation,
    };
  }

  factory GothQueen.fromJson(Map<String, dynamic> json) {
    return GothQueen(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      appearance: json['appearance'] as String,
      needs: Needs.fromJson(json['needs'] as Map<String, dynamic>),
      stats: CharacterStats.fromJson(json['stats'] as Map<String, dynamic>),
      skills: Skills.fromJson(json['skills'] as Map<String, dynamic>),
      traits: (json['traits'] as List<dynamic>)
          .map((t) => TraitExtension.fromJson(t as String))
          .toList(),
      currentLocation: json['currentLocation'] as String?,
    );
  }

  /// Create a sample Goth Queen for testing
  factory GothQueen.sample() {
    return const GothQueen(
      id: 'sample_1',
      name: 'Raven Nightshade',
      description:
          'A mysterious figure draped in black lace and shadows. '
          'Her presence commands both fear and admiration.',
      appearance:
          'Tall and elegant, with long black hair cascading over '
          'a Victorian-style dress adorned with silver chains. Dark eyeliner '
          'accentuates piercing eyes that seem to look through you.',
      needs: Needs(
        alignment: 0.7,
        intellectual: 0.8,
        solitude: 0.6,
        social: 0.3,
        aesthetic: 0.9,
        validation: 0.2,
        caffeine: 0.7,
        alcohol: 0.4,
        nicotine: 0.5,
      ),
      stats: CharacterStats(mood: 0.6, sanity: 0.5, friendship: 0.0),
      skills: Skills(
        gravitas: 0.9,
        aestheticism: 0.8,
        alchemy: 0.6,
        charisma: 0.7,
        occult: 0.8,
        combat: 0.4,
        tech: 0.5,
      ),
      traits: [Trait.poet, Trait.voidTouched, Trait.nocturnal],
      currentLocation: 'The Obsidian Cafe',
    );
  }
}
