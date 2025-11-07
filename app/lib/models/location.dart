/// Represents a location in Nocturne Square
///
/// Nocturne Square is a modern business park built like a labyrinth.
/// Sunlight is laced with ivy. Pools with pale fish and abandoned terrapins.
/// Escalators that lead to empty food courts and secret libraries.
class Location {
  final String id;
  final String name;
  final String description;

  /// Visual atmosphere of the location
  final String atmosphere;

  /// Type of location (cafe, library, gym, etc.)
  final LocationType type;

  /// Queens that can be found here
  final List<String> queenIds;

  const Location({
    required this.id,
    required this.name,
    required this.description,
    required this.atmosphere,
    required this.type,
    this.queenIds = const [],
  });

  Location copyWith({
    String? id,
    String? name,
    String? description,
    String? atmosphere,
    LocationType? type,
    List<String>? queenIds,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      atmosphere: atmosphere ?? this.atmosphere,
      type: type ?? this.type,
      queenIds: queenIds ?? this.queenIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'atmosphere': atmosphere,
      'type': type.name,
      'queenIds': queenIds,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      atmosphere: json['atmosphere'] as String,
      type: LocationType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => LocationType.other,
      ),
      queenIds:
          (json['queenIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  /// Sample locations in Nocturne Square
  static List<Location> getSampleLocations() {
    return [
      const Location(
        id: 'obsidian_cafe',
        name: 'The Obsidian Cafe',
        description:
            'A dimly lit cafe where coffee is always black and the '
            'playlist is always melancholic.',
        atmosphere:
            'Dark wood panels, Edison bulbs casting amber shadows, '
            'the smell of espresso and old books.',
        type: LocationType.cafe,
      ),
      const Location(
        id: 'void_library',
        name: 'The Void Library',
        description:
            'A secret library hidden at the top of an escalator. '
            'Most books are about occult lore and forgotten poetry.',
        atmosphere:
            'Silence broken only by the turning of ancient pages. '
            'Dust motes dance in shafts of dim light.',
        type: LocationType.library,
      ),
      const Location(
        id: 'goth_grocery',
        name: 'Eternal Halloween',
        description:
            'A large goth grocery where it\'s always Halloween. '
            'Black roses, skull-shaped candles, and artisanal bitters.',
        atmosphere:
            'Perpetual October evening. Orange and purple lights, '
            'the scent of pumpkin spice and incense.',
        type: LocationType.shop,
      ),
      const Location(
        id: 'concrete_courtyard',
        name: 'The Concrete Courtyard',
        description:
            'A large concrete courtyard where people spar with bokken '
            'at sunset and run in silence.',
        atmosphere:
            'Brutalist architecture meets twilight. The sound of '
            'wooden swords and measured breathing.',
        type: LocationType.outdoor,
      ),
    ];
  }
}

enum LocationType {
  cafe,
  library,
  shop,
  gym,
  restaurant,
  studio,
  office,
  outdoor,
  bookstore,
  other,
}

extension LocationTypeExtension on LocationType {
  String get displayName {
    switch (this) {
      case LocationType.cafe:
        return 'Cafe';
      case LocationType.library:
        return 'Library';
      case LocationType.shop:
        return 'Shop';
      case LocationType.gym:
        return 'Gym';
      case LocationType.restaurant:
        return 'Restaurant';
      case LocationType.studio:
        return 'Studio';
      case LocationType.office:
        return 'Office';
      case LocationType.outdoor:
        return 'Outdoor';
      case LocationType.bookstore:
        return 'Bookstore';
      case LocationType.other:
        return 'Other';
    }
  }
}
