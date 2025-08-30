import 'package:flutter/material.dart';
import 'appcolors.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.primary,
  appBarTheme: AppBarTheme(
    color: AppColors.darkBlue,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  cardColor: AppColors.darkBlue.withOpacity(0.8),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkBlue.withOpacity(0.6),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondary, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 39,),
    titleMedium: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 39),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.accent,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondary,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);
