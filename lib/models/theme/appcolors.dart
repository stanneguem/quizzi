import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0A1331);
  static const Color secondary = Color(0xFFB3CFE5);
  static const Color accent = Color(0xFF4A7FA7);
  static const Color darkBlue = Color(0xFF1A3D63);
  static const Color backgroundLight = Color(0xFFF6FAFD);

  /// Dégradé principal - pour les boutons primaires
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, darkBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Dégradé secondaire - pour les boutons secondaires
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, accent],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Dégradé d'accentuation - pour boutons spéciaux ou CTA
  static const LinearGradient accentGradient = LinearGradient(
    colors: [primary, accent, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
