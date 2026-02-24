import 'package:flutter/material.dart';

class GoogleColors {
  // Primary Google Colors
  static const Color blue = Color(0xFF4285F4);
  static const Color red = Color(0xFFDB4437);
  static const Color yellow = Color(0xFFF4B400);
  static const Color green = Color(0xFF0F9D58);

  // Light variants
  static const Color blueLight = Color(0xFF8AB4F8);
  static const Color redLight = Color(0xFFF28B82);
  static const Color yellowLight = Color(0xFFFDD663);
  static const Color greenLight = Color(0xFF81C995);

  // Dark variants
  static const Color blueDark = Color(0xFF1967D2);
  static const Color redDark = Color(0xFFC5221F);
  static const Color yellowDark = Color(0xFFE37400);
  static const Color greenDark = Color(0xFF188038);

  // Background colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF202124);

  // Surface colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF303134);

  // Text colors
  static const Color textPrimary = Color(0xFF202124);
  static const Color textSecondary = Color(0xFF5F6368);
  static const Color textLight = Color(0xFFFFFFFF);

  // Gradient combinations
  static const List<Color> gradientBlueGreen = [blue, green];
  static const List<Color> gradientRedYellow = [red, yellow];
  static const List<Color> gradientAllColors = [blue, red, yellow, green];

  // Category colors
  static List<Color> categoryColors = [
    blue,
    red,
    yellow,
    green,
    const Color(0xFF9C27B0), // Purple
    const Color(0xFF00BCD4), // Cyan
    const Color(0xFFFF5722), // Deep Orange
    const Color(0xFF607D8B), // Blue Grey
  ];

  static Color getCategoryColor(int index) {
    return categoryColors[index % categoryColors.length];
  }

  // Gradient for cards
  static LinearGradient getCardGradient(Color color) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color,
        color.withOpacity(0.8),
      ],
    );
  }
}
