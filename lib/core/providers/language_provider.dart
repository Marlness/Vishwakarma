import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vishwakarmas/core/constants/app_constants.dart';

class LanguageProvider extends ChangeNotifier {
  final SharedPreferences _preferences;
  Locale _locale = const Locale('en', 'US'); // Default language is English
  
  LanguageProvider(this._preferences) {
    _loadLocale();
  }
  
  // Getter
  Locale get locale => _locale;
  
  // Load locale from shared preferences
  void _loadLocale() {
    final languageCode = _preferences.getString(AppConstants.languageCodeKey);
    if (languageCode != null) {
      switch (languageCode) {
        case 'en':
          _locale = const Locale('en', 'US');
          break;
        case 'kn':
          _locale = const Locale('kn', 'IN');
          break;
        default:
          _locale = const Locale('en', 'US');
          break;
      }
    }
    notifyListeners();
  }
  
  // Set language
  Future<void> setLanguage(String languageCode) async {
    switch (languageCode) {
      case 'en':
        _locale = const Locale('en', 'US');
        break;
      case 'kn':
        _locale = const Locale('kn', 'IN');
        break;
      default:
        _locale = const Locale('en', 'US');
        break;
    }
    await _preferences.setString(AppConstants.languageCodeKey, languageCode);
    notifyListeners();
  }
  
  // Check if current language is English
  bool isEnglish() {
    return _locale.languageCode == 'en';
  }
  
  // Check if current language is Kannada
  bool isKannada() {
    return _locale.languageCode == 'kn';
  }
}
