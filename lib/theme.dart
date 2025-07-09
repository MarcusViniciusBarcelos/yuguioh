import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YugiTheme {
  static const gold   = Color(0xFFBA8C00);
  static const scarlet = Color(0xFFB71C1C);

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    final roboto = GoogleFonts.robotoTextTheme(base.textTheme);
    final mixed = roboto.copyWith(
      displayLarge: const TextStyle(
        fontFamily: 'Yugi',
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: gold,
      ),
      titleLarge: const TextStyle(
        fontFamily: 'Yugi',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: gold,
      ),
    );


    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: gold,
        primary: gold,
        secondary: scarlet,
        onPrimary: Colors.black,
      ),

      scaffoldBackgroundColor: const Color(0xCCF9F6EE),
      textTheme: mixed,

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: gold,
        elevation: 4,
      ),

      tabBarTheme: const TabBarThemeData(
        indicatorColor: scarlet,
        labelColor: gold,
        unselectedLabelColor: Colors.white70,
      ),

      cardTheme: CardThemeData(
        color: const Color(0xFFF1E7CE),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: gold, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      chipTheme: base.chipTheme.copyWith(
        backgroundColor: const Color(0xFFFFF6DD),
        side: const BorderSide(color: gold),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,

          color: Colors.black,
        ),
      ),
    );
  }
}