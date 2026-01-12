import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/features/settings/domain/entities/user_settings_data.dart';

/// Service responsible for managing application locale settings.
///
/// Handles system language detection, user language preferences,
/// and persistence of language settings.
class LocaleService {
  static const String _keyAppLanguage = 'app_language';
  static const String _keyUseSystemLanguage = 'use_system_language';
  static const String _keyLocaleInitialized = 'locale_initialized';

  final SharedPreferences _prefs;

  /// Supported language codes with their display names
  static const Map<String, String> languageNames = {
    UserSettingsData.languageEnglish: 'English',
    UserSettingsData.languageRussian: 'Русский',
    UserSettingsData.languageUkrainian: 'Українська',
    UserSettingsData.languageGerman: 'Deutsch',
    UserSettingsData.languageFrench: 'Français',
  };

  /// Language code to native name mapping
  static const Map<String, String> nativeLanguageNames = {
    UserSettingsData.languageEnglish: 'English',
    UserSettingsData.languageRussian: 'Русский',
    UserSettingsData.languageUkrainian: 'Українська',
    UserSettingsData.languageGerman: 'Deutsch',
    UserSettingsData.languageFrench: 'Français',
  };

  const LocaleService({required SharedPreferences prefs}) : _prefs = prefs;

  /// Checks if this is the first app launch.
  ///
  /// Returns true if locale has not been initialized yet.
  Future<bool> isFirstLaunch() async {
    final initialized = _prefs.getBool(_keyLocaleInitialized);
    return initialized != true;
  }

  /// Marks the locale as initialized (first launch complete).
  Future<void> markLocaleInitialized() async {
    await _prefs.setBool(_keyLocaleInitialized, true);
  }

  /// Gets the system's current locale.
  ///
  /// Returns the device's primary locale or fallback to English.
  Future<Locale> getSystemLocale() async {
    final systemLocale = PlatformDispatcher.instance.locale;
    return _mapToSupportedLocale(systemLocale);
  }

  /// Gets the user's saved language preference.
  ///
  /// Returns the saved language code or null if not set.
  Future<String?> getSavedLanguage() async {
    return _prefs.getString(_keyAppLanguage);
  }

  /// Gets whether the user prefers to use system language.
  Future<bool> getUseSystemLanguage() async {
    return _prefs.getBool(_keyUseSystemLanguage) ?? true;
  }

  /// Saves the user's language preference.
  ///
  /// [languageCode] The language code (e.g., 'en', 'ru', 'uk').
  Future<void> setAppLanguage(String languageCode) async {
    await _prefs.setString(_keyAppLanguage, languageCode);
    await _prefs.setBool(_keyUseSystemLanguage, false);
    await markLocaleInitialized();
  }

  /// Sets whether to use the system language.
  ///
  /// [useSystem] True to use system language, false to use saved preference.
  Future<void> setUseSystemLanguage(bool useSystem) async {
    await _prefs.setBool(_keyUseSystemLanguage, useSystem);
    await markLocaleInitialized();
  }

  /// Determines the initial locale to use on app startup.
  ///
  /// Priority:
  /// 1. If this is first launch, detect and use system language
  /// 2. If user disabled system language, use saved preference
  /// 3. If system language is supported, use it
  /// 4. Fallback to English
  Future<Locale> determineInitialLocale() async {
    final isFirstRun = await isFirstLaunch();

    if (isFirstRun) {
      // First launch: detect system language and use it
      final systemLocale = await getSystemLocale();
      await _setDefaultLocaleForFirstLaunch(systemLocale);
      return systemLocale;
    }

    // Not first launch: check user preferences
    final useSystem = await getUseSystemLanguage();

    if (!useSystem) {
      final savedLanguage = await getSavedLanguage();
      if (savedLanguage != null && _isLanguageSupported(savedLanguage)) {
        return Locale(savedLanguage);
      }
    }

    // Use system language or fallback to English
    final systemLocale = await getSystemLocale();
    return systemLocale;
  }

  /// Sets default locale values for first launch.
  Future<void> _setDefaultLocaleForFirstLaunch(Locale locale) async {
    await _prefs.setString(_keyAppLanguage, locale.languageCode);
    await _prefs.setBool(_keyUseSystemLanguage, true);
    await markLocaleInitialized();
  }

  /// Initializes locale for a new user.
  ///
  /// Should be called when a new user is created or on first run.
  /// Returns the detected system locale.
  Future<Locale> initializeLocaleForUser() async {
    final systemLocale = await getSystemLocale();
    await _setDefaultLocaleForFirstLaunch(systemLocale);
    return systemLocale;
  }

  /// Gets the display name for a language code.
  ///
  /// [languageCode] The language code.
  /// Returns the display name or the code itself if not found.
  String getLanguageName(String languageCode) {
    return languageNames[languageCode] ?? languageCode.toUpperCase();
  }

  /// Gets the native name for a language code.
  ///
  /// [languageCode] The language code.
  /// Returns the native name or the code itself if not found.
  String getNativeLanguageName(String languageCode) {
    return nativeLanguageNames[languageCode] ?? languageCode.toUpperCase();
  }

  /// Checks if a language code is supported.
  ///
  /// [languageCode] The language code to check.
  /// True if the language is supported.
  bool isLanguageSupported(String languageCode) {
    return UserSettingsData.supportedLanguages.contains(languageCode);
  }

  /// Maps a platform locale to a supported app locale.
  ///
  /// [locale] The platform locale.
  /// Returns the closest supported locale or English as fallback.
  Locale _mapToSupportedLocale(Locale locale) {
    final languageCode = locale.languageCode;

    if (_isLanguageSupported(languageCode)) {
      return Locale(languageCode);
    }

    // Handle special cases for similar languages
    if (languageCode == 'be' || languageCode == 'kk') {
      return const Locale('ru'); // Fallback to Russian
    }

    // Default to English
    return const Locale(UserSettingsData.languageEnglish);
  }

  /// Checks if a language code is supported by the app.
  bool _isLanguageSupported(String languageCode) {
    return UserSettingsData.supportedLanguages.contains(languageCode);
  }

  /// Gets the list of all supported language codes.
  List<String> get supportedLanguages => UserSettingsData.supportedLanguages;

  /// Resets all locale settings (useful for testing or logout).
  Future<void> resetLocaleSettings() async {
    await _prefs.remove(_keyAppLanguage);
    await _prefs.remove(_keyUseSystemLanguage);
    await _prefs.remove(_keyLocaleInitialized);
  }
}
