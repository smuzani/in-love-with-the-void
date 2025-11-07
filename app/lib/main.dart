import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'theme/app_theme.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/game_viewmodel.dart';
import 'viewmodels/character_viewmodel.dart';
import 'views/home/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // .env file not found - app will use default/empty values
    // Make sure to create .env file from .env.example
    debugPrint('Warning: Could not load .env file: $e');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => GameViewModel()),
        ChangeNotifierProvider(create: (_) => CharacterViewModel()),
      ],
      child: MaterialApp(
        title: 'In Love With The Void',
        theme: AppTheme.darkTheme,
        home: const HomeView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
