import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: const Color(0xFF2ec9bf),
    primaryColorDark: const Color(0xFF00796B),
    primaryColorLight: const Color(0xFFB2DFDB),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xFFFFC107), // Amber
      surface: const Color(0xFFF0F0F0), // Light Grey
      onPrimary: Colors.white, // White text on primary color
      onSecondary: Colors.black, // Black text on secondary color
    ),
    secondaryHeaderColor: const Color(0xFF483D8B), // Dark Slate Blue
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      displayLarge: TextStyle(color: const Color(0xFF1B070B), fontWeight: FontWeight.bold, fontSize: 36),
      displayMedium: TextStyle(color: const Color(0xFF1B070B), fontWeight: FontWeight.bold, fontSize: 24),
      displaySmall: TextStyle(color: const Color(0xFF1B070B), fontWeight: FontWeight.bold, fontSize: 18),
      bodyLarge: TextStyle(color: const Color(0xFF1B070B), fontWeight: FontWeight.normal, fontSize: 12),
      bodyMedium: TextStyle(color: const Color(0xFF1B070B), fontWeight: FontWeight.normal, fontSize: 10),
    ),
  );
}

