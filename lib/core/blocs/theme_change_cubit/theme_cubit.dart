import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_app/core/shared_prefs.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPrefs sharedPrefs;

  ThemeCubit({required this.sharedPrefs}) : super(ThemeState.initial()) {
    _loadTheme();
  }

  void _loadTheme() {
    final themeMode = sharedPrefs.themeMode;
    emit(ThemeState(themeMode: _parseThemeMode(themeMode)));
  }

  void toggleTheme() {
    final newMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    sharedPrefs.setThemeMode(_themeModeToString(newMode));
    emit(ThemeState(themeMode: newMode));
  }

  void setThemeMode(ThemeMode mode) {
    sharedPrefs.setThemeMode(_themeModeToString(mode));
    emit(ThemeState(themeMode: mode));
  }

  ThemeMode _parseThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
