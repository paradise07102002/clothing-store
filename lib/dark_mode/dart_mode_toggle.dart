import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart';

class DarkModeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return Switch(
          value: themeNotifier.isDarkMode,
          onChanged: (value) {
            themeNotifier.toggleTheme();
          },
        );
      },
    );
  }
}
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black, // Màu chính
  // Các thuộc tính khác của theme
);