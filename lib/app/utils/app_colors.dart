import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF643D32);
  static const Color secondary = Color(0xFF8B3E14);

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color border = Color(0xFFD9D9D9);
  static const Color hint = Color(0xFFB0B0B0);
  static const Color logoLetter = Color(0xFFB8B8B8);
  static const Color screenBackground = Color(0xFFF8F8F8);
  static const Color sheetHeaderBackground = Color(0xFFF3F3F3);
  static const Color selectedCheck = Color(0xFF1B6B3A);
  static const Color orderSuccess = Color(0xFF0F8A5F);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primary, secondary],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [secondary, primary],
  );
}
