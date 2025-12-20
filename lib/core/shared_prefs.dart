import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/core/constants/app_constants.dart';

class SharedPrefs {
  final SharedPreferences _sharedPreferences;

  SharedPrefs(this._sharedPreferences);

  Future<bool> setIsFirstLaunch(bool value) async {
    return _sharedPreferences.setBool(AppConstants.keyIsFirstLaunch, value);
  }

  bool get isFirstLaunch {
    return _sharedPreferences.getBool(AppConstants.keyIsFirstLaunch) ?? true;
  }

  Future<bool> setHasPassword(bool value) async {
    return _sharedPreferences.setBool(AppConstants.keyHasPassword, value);
  }

  bool get hasPassword {
    return _sharedPreferences.getBool(AppConstants.keyHasPassword) ?? false;
  }

  Future<bool> setUseBiometric(bool value) async {
    return _sharedPreferences.setBool(AppConstants.keyUseBiometric, value);
  }

  bool get useBiometric {
    return _sharedPreferences.getBool(AppConstants.keyUseBiometric) ?? false;
  }

  Future<bool> setSelectedCurrency(String currency) async {
    return _sharedPreferences.setString(
      AppConstants.keySelectedCurrency,
      currency,
    );
  }

  String get selectedCurrency {
    return _sharedPreferences.getString(AppConstants.keySelectedCurrency) ??
        AppConstants.defaultCurrency;
  }

  Future<bool> setThemeMode(String themeMode) async {
    return _sharedPreferences.setString(AppConstants.keyThemeMode, themeMode);
  }

  String get themeMode {
    return _sharedPreferences.getString(AppConstants.keyThemeMode) ?? 'system';
  }

  Future<bool> clearAll() async {
    return _sharedPreferences.clear();
  }

  Future<bool> remove(String key) async {
    return _sharedPreferences.remove(key);
  }
}
