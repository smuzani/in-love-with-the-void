import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/game_viewmodel.dart';
import 'viewmodels/character_viewmodel.dart';
import 'views/home/home_view.dart';

void main() {
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
