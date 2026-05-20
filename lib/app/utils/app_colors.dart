import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF643D32);
  static const Color secondary = Color(0xFF8B3E14);

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
