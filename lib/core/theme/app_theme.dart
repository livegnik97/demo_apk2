import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF2862f5);

const List<Color> colorThemes = [
  _customColor,
  Colors.red,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

class AppTheme {
  final int selectedColor;
  final bool isDark;

  static const double borderRadius = 30;

  AppTheme({this.selectedColor = 0, this.isDark = false});

  ThemeData theme() {
    return _theme(isDark);
  }

  ThemeData themeLight() {
    return _theme(false);
  }

  ThemeData themeDark() {
    return _theme(true);
  }

  ThemeData _theme(bool isDarkMode) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorThemes[selectedColor % colorThemes.length],
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        // elevation: 20,
      ),
    );
  }

  AppTheme copyWith({
    int? selectedColor,
    bool? isDark,
  }) {
    return AppTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      isDark: isDark ?? this.isDark,
    );
  }
}
