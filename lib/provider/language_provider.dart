import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void changeLanguage(String languageCode) {
    _locale = Locale(languageCode);
    notifyListeners();
  }
}