# MVVM Architecture Implementation

This document describes the MVVM (Model-View-ViewModel) architecture implemented in the Flutter app for "In Love With The Void".

## Architecture Overview

```
┌─────────────┐
│    View     │ ← UI Layer (Widgets)
└──────┬──────┘
       │ observes & triggers
┌──────▼──────┐
│ ViewModel   │ ← Business Logic & State
└──────┬──────┘
       │ uses
┌──────▼──────┐
│ Repository  │ ← Data Access Layer
└──────┬──────┘
       │ fetches
┌──────▼──────┐
│   Model     │ ← Data Models
└─────────────┘
```

## Folder Structure

```
lib/
├── main.dart                      # App entry point with Provider setup
├── models/                        # Data models
│   ├── goth_queen.dart           # Main character model
│   ├── location.dart             # Location model
│   ├── traits.dart               # Personality traits enum
│   └── stats/                    # Rimworld-style stats
│       ├── needs.dart            # 9 needs system
│       ├── character_stats.dart  # Mood, Sanity, Friendship
│       └── skills.dart           # 7 skills
├── views/                        # UI screens
│   ├── home/
│   │   └── home_view.dart        # Main menu
│   ├── game/
│   │   └── game_view.dart        # VN-style game interface
│   └── character/
│       └── character_profile_view.dart  # Character stats display
├── viewmodels/                   # Business logic
│   ├── base_viewmodel.dart       # Base class with common functionality
│   ├── home_viewmodel.dart       # Home screen logic
│   ├── game_viewmodel.dart       # Game logic & state
│   └── character_viewmodel.dart  # Character management
├── repositories/                 # Data access layer
│   ├── queen_repository.dart     # Goth Queen data access
│   └── location_repository.dart  # Location data access
├── services/                     # External services
│   └── config_service.dart       # Environment config (placeholder)
└── widgets/                      # Reusable components
    └── stat_display.dart         # Stat bar widget
```

## Components

### Models

All models are immutable and include:
- JSON serialization (`toJson`/`fromJson`)
- `copyWith` methods for updates
- Factory constructors for samples/testing

**Key Models:**
- `GothQueen` - Main character with stats, needs, skills, traits
- `Location` - Places in Nocturne Square
- `Needs` - 9 needs: Alignment, Intellectual, Solitude, Social, Aesthetic, Validation, Caffeine, Alcohol, Nicotine
- `CharacterStats` - Mood, Sanity, Friendship
- `Skills` - Gravitas, Aestheticism, Alchemy, Charisma, Occult, Combat, Tech
- `Trait` - Enum with: Nihilist, Nocturnal, Poet, Siren, Bitch, Void-touched, Oracle

### ViewModels

All ViewModels extend `BaseViewModel` which provides:
- `isBusy` - Loading state
- `errorMessage` - Error handling
- `runBusyFuture` - Async operation wrapper
- `notifyListeners()` - Provider integration

**ViewModels:**
- `HomeViewModel` - Location list, navigation
- `GameViewModel` - Story text, player input, game state
- `CharacterViewModel` - Character profile display

### Repositories

Repository pattern for data access:
- Abstract interfaces define contracts
- Mock implementations for development
- Ready for Supabase/LLM integration

**Repositories:**
- `QueenRepository` - CRUD for Goth Queens
- `LocationRepository` - Location management

### Views

Mobile-friendly, dark goth aesthetic:
- Purple/black color scheme
- VN-style text display
- Stat visualization with progress bars

**Screens:**
- `HomeView` - Entry screen with location preview
- `GameView` - Main VN interface with text input
- `CharacterProfileView` - Detailed character stats

## State Management

Using **Provider** package:
- ViewModels extend `ChangeNotifier`
- Views consume state with `Consumer<T>` widget
- Providers registered in `main.dart` with `MultiProvider`

Example usage:
```dart
Consumer<GameViewModel>(
  builder: (context, viewModel, child) {
    return Text(viewModel.storyText);
  },
)
```

## Data Flow

1. **User Action** → View captures input
2. **View** → Calls ViewModel method
3. **ViewModel** → Updates state, calls Repository
4. **Repository** → Fetches/saves data
5. **ViewModel** → `notifyListeners()`
6. **View** → Rebuilds with new state

## Next Steps

### Immediate
- [ ] Add `.env` file for environment variables
- [ ] Install Supabase SDK
- [ ] Implement actual game logic in GameViewModel
- [ ] Add more locations and queens

### Future
- [ ] Integrate LLM for dynamic content generation
- [ ] Implement win condition logic
- [ ] Add save/load functionality
- [ ] Create more UI polish and animations
- [ ] Add sound effects and music
- [ ] Implement full stats effects on dialogue

## Environment Setup

See `lib/services/config_service.dart` for detailed instructions on setting up environment variables for:
- Supabase URL and keys
- OpenAI/LLM API keys

## Running the App

```bash
cd app
flutter pub get
flutter run
```

## Testing

Currently no tests implemented. Future testing structure:
```
test/
├── models/        # Model tests
├── viewmodels/    # ViewModel tests (mock repositories)
├── repositories/  # Repository tests
└── widgets/       # Widget tests
```

## Design Patterns Used

1. **MVVM** - Separation of concerns
2. **Repository Pattern** - Data access abstraction
3. **Provider/Observer** - State management
4. **Factory Pattern** - Model creation
5. **Singleton** - ConfigService (static)

## Notes

- No dependency injection container (keeping it simple per user request)
- Mock repositories return sample data with simulated delays
- All stats use 0.0-1.0 range for consistency
- VN-style interface uses text input for player commands
- Dark aesthetic throughout (purple/black/grey)
