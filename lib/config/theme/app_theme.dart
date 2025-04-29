import 'package:flutter/material.dart';

class AppTheme {
  get current => ThemeData(
      useMaterial3: true, colorSchemeSeed: const Color(0xFF2862F5), brightness: Brightness.dark);
}
