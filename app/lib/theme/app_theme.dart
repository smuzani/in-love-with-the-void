import 'package:flutter/material.dart';

////////
/// FIXME: in prototype mode, colors suck
///////
class AppTheme {
  // Blacks
  static const jetBlack    = Color(0xFF0B0B0B);
  static const coalBlack   = Color(0xFF141414);
  static const charcoal    = Color(0xFF1E1E1E);
  static const graphite    = Color(0xFF2A2A2A);

  // Whites 
  static const boneWhite   = Color(0xFFEDE7E1);
  static const paperWhite  = Color(0xFFF5F3EF);
  static const ash         = Color(0xFFC9C4BE);

  // Reds
  static const bloodRed    = Color(0xFFB30014);
  static const driedCrimson= Color(0xFF6E000A);
  static const alarmScarlet= Color(0xFFFF2B2B);

  // Metal
  static const scuffedSilver = Color(0xFF9DA0A3);
  static const iron          = Color(0xFF707478);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,

      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: bloodRed,
        onPrimary: paperWhite,
        primaryContainer: driedCrimson,
        onPrimaryContainer: paperWhite,

        secondary: scuffedSilver,           // subtle accent (icons, chips)
        onSecondary: jetBlack,
        secondaryContainer: iron,
        onSecondaryContainer: boneWhite,

        tertiary: boneWhite,                // highlights on dark surfaces
        onTertiary: jetBlack,

        error: alarmScarlet,
        onError: paperWhite,

        surface: coalBlack,
        onSurface: boneWhite,
        surfaceContainerHighest: charcoal,

        outline: iron,
        outlineVariant: graphite,

        shadow: jetBlack,
        scrim: jetBlack,
      ),

      scaffoldBackgroundColor: jetBlack,

      appBarTheme: const AppBarTheme(
        backgroundColor: coalBlack,
        foregroundColor: boneWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: boneWhite,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.6,
        ),
      ),

      cardTheme: CardThemeData(
        color: coalBlack,
        elevation: 3,
        shadowColor: jetBlack.withValues(alpha: 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: graphite, width: 1),
        ),
      ),

      textTheme: const TextTheme(
        displayLarge:   TextStyle(color: paperWhite, fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 1.2),
        displayMedium:  TextStyle(color: paperWhite, fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 1.1),
        displaySmall:   TextStyle(color: paperWhite, fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 1.0),

        headlineLarge:  TextStyle(color: boneWhite,  fontSize: 22, fontWeight: FontWeight.w500),
        headlineMedium: TextStyle(color: boneWhite,  fontSize: 20, fontWeight: FontWeight.w500),
        headlineSmall:  TextStyle(color: boneWhite,  fontSize: 18, fontWeight: FontWeight.w500),

        bodyLarge:      TextStyle(color: ash,        fontSize: 16, fontWeight: FontWeight.w400, height: 1.35),
        bodyMedium:     TextStyle(color: ash,        fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall:      TextStyle(color: scuffedSilver, fontSize: 12, fontWeight: FontWeight.w400),

        labelLarge:     TextStyle(color: scuffedSilver, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1.1),
        labelMedium:    TextStyle(color: scuffedSilver, fontSize: 12, fontWeight: FontWeight.w600),
        labelSmall:     TextStyle(color: iron,          fontSize: 10, fontWeight: FontWeight.w500),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: charcoal,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: iron),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: iron),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: bloodRed, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: alarmScarlet),
        ),
        labelStyle: const TextStyle(color: scuffedSilver),
        hintStyle: const TextStyle(color: iron),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: bloodRed,
          foregroundColor: paperWhite,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.1),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scuffedSilver,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: boneWhite,
          side: const BorderSide(color: bloodRed, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.1),
        ),
      ),

      iconTheme: const IconThemeData(size: 24, color: scuffedSilver),

      dividerTheme: const DividerThemeData(color: graphite, thickness: 1, space: 1),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: bloodRed,
        linearTrackColor: graphite,
        circularTrackColor: graphite,
      ),
    );
  }
}