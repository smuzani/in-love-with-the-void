# Setup Instructions

## API Configuration

1. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```

2. Add your Anthropic API key to `.env`:
   ```
   ANTHROPIC_API_KEY=sk-ant-your-key-here
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## How It Works

When a player types into the prompt in the game view, the text is sent to Claude Haiku 4.5 with context about:
- Current location and atmosphere
- Current goth queen character and their stats
- Conversation history (last 10 exchanges)
- Game aesthetic and style guidelines

Claude responds as the narrator, describing what happens based on player input while maintaining the dark, poetic, goth aesthetic.

## Files Modified

- `lib/services/claude_service.dart` - New service for Claude API calls
- `lib/viewmodels/game_viewmodel.dart` - Integrated Claude into player input processing
- `lib/main.dart` - Added .env loading
- `pubspec.yaml` - Added http package dependency
- `.gitignore` - Added .env to prevent committing API keys
