import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final _storage = GetStorage();
  
  // Storage Keys
  static const String _themeKey = 'theme_mode_dark';
  static const String _langKey = 'app_language_code';

  final RxBool isDarkMode = false.obs;
  final RxString languageCode = 'ar'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  void _loadFromStorage() {
    // 1. Load Theme Mode
    final bool? savedTheme = _storage.read<bool>(_themeKey);
    if (savedTheme != null) {
      isDarkMode.value = savedTheme;
    } else {
      // Default to system settings if nothing saved
      isDarkMode.value = Get.isPlatformDarkMode;
    }
    _applyTheme();

    // 2. Load Language Locale
    final String? savedLang = _storage.read<String>(_langKey);
    if (savedLang != null) {
      languageCode.value = savedLang;
    } else {
      languageCode.value = 'ar'; // Default language to Arabic
    }
    _applyLocale();
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    _storage.write(_themeKey, value);
    _applyTheme();
  }

  void changeLanguage(String langCode) {
    languageCode.value = langCode;
    _storage.write(_langKey, langCode);
    _applyLocale();
  }

  void _applyTheme() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void _applyLocale() {
    Get.updateLocale(Locale(languageCode.value));
  }
}
