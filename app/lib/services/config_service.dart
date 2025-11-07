/// Configuration service for environment variables and API keys
///
/// This is a placeholder implementation. In production:
/// 1. Add flutter_dotenv package
/// 2. Create .env file with actual keys
/// 3. Add .env to .gitignore
/// 4. Load environment variables via dotenv.load()
class ConfigService {
  // TODO: Replace with actual environment variables
  // Use flutter_dotenv to load from .env file

  /// Supabase project URL
  /// Add to .env as: SUPABASE_URL=your_url_here
  static String get supabaseUrl {
    // return dotenv.env['SUPABASE_URL'] ?? '';
    return 'YOUR_SUPABASE_URL_HERE';
  }

  /// Supabase anonymous key
  /// Add to .env as: SUPABASE_ANON_KEY=your_key_here
  static String get supabaseAnonKey {
    // return dotenv.env['SUPABASE_ANON_KEY'] ?? '';
    return 'YOUR_SUPABASE_ANON_KEY_HERE';
  }

  /// OpenAI API key (if using for LLM generation)
  /// Add to .env as: OPENAI_API_KEY=your_key_here
  static String get openAiApiKey {
    // return dotenv.env['OPENAI_API_KEY'] ?? '';
    return 'YOUR_OPENAI_API_KEY_HERE';
  }

  /// Initialize the config service
  /// Call this before runApp() in main.dart
  static Future<void> initialize() async {
    // TODO: Uncomment when using dotenv
    // await dotenv.load(fileName: ".env");
  }

  /// Check if configuration is valid
  static bool get isConfigured {
    return supabaseUrl.isNotEmpty &&
           !supabaseUrl.contains('YOUR_') &&
           supabaseAnonKey.isNotEmpty &&
           !supabaseAnonKey.contains('YOUR_');
  }
}

/*
 * SETUP INSTRUCTIONS:
 *
 * 1. Add to pubspec.yaml:
 *    dependencies:
 *      flutter_dotenv: ^5.1.0
 *
 * 2. Create .env file in app/ directory:
 *    SUPABASE_URL=your_supabase_project_url
 *    SUPABASE_ANON_KEY=your_supabase_anon_key
 *    OPENAI_API_KEY=your_openai_api_key
 *
 * 3. Add .env to .gitignore:
 *    echo ".env" >> .gitignore
 *
 * 4. Update pubspec.yaml to include .env in assets:
 *    flutter:
 *      assets:
 *        - .env
 *
 * 5. Uncomment the dotenv code in this file
 *
 * 6. In main.dart, initialize before runApp:
 *    void main() async {
 *      WidgetsFlutterBinding.ensureInitialized();
 *      await ConfigService.initialize();
 *      runApp(const MainApp());
 *    }
 */
