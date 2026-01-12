import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/services/locale_service.dart';
import 'package:test_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:test_app/injection_container.dart';

/// A widget that provides dynamic locale switching functionality.
///
/// Listens to [SettingsCubit] state changes and rebuilds the child widget
/// with the appropriate locale when the language settings change.
class LocaleBuilder extends StatefulWidget {
  /// The widget to build with the current locale.
  final Widget Function(Locale locale) builder;

  const LocaleBuilder({super.key, required this.builder});

  @override
  State<LocaleBuilder> createState() => _LocaleBuilderState();
}

class _LocaleBuilderState extends State<LocaleBuilder> {
  Locale? _currentLocale;

  @override
  void initState() {
    super.initState();
    _initializeLocale();
  }

  Future<void> _initializeLocale() async {
    final localeService = LocaleService(prefs: sl());
    final initialLocale = await localeService.determineInitialLocale();

    if (mounted) {
      setState(() {
        _currentLocale = initialLocale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoaded) {
          final newLocale = _determineLocaleFromState(state);
          if (newLocale != _currentLocale && mounted) {
            setState(() {
              _currentLocale = newLocale;
            });
          }
        }
      },
      child: _currentLocale != null
          ? widget.builder(_currentLocale!)
          : const SizedBox.shrink(),
    );
  }

  Locale _determineLocaleFromState(SettingsLoaded state) {
    final settings = state.settings;

    if (settings.useSystemLanguage) {
      return PlatformDispatcher.instance.locale;
    }

    return Locale(settings.appLanguage);
  }
}

/// Extension to get device locale.
extension LocaleExtension on BuildContext {
  /// Gets the device's current locale.
  Locale get deviceLocale => PlatformDispatcher.instance.locale;
}

/// Mixin that provides locale-aware rebuild functionality.
mixin LocaleAwareMixin<T extends StatefulWidget> on State<T> {
  Locale? _currentLocale;

  @override
  void initState() {
    super.initState();
    _setupLocaleListener();
  }

  void _setupLocaleListener() {
    final cubit = sl<SettingsCubit>();
    cubit.stream.listen((state) {
      if (state is SettingsLoaded && mounted) {
        final newLocale = _getLocaleFromSettings(state);
        if (newLocale != _currentLocale) {
          setState(() {
            _currentLocale = newLocale;
          });
        }
      }
    });
  }

  Locale _getLocaleFromSettings(SettingsLoaded state) {
    final settings = state.settings;

    if (settings.useSystemLanguage) {
      return PlatformDispatcher.instance.locale;
    }

    return Locale(settings.appLanguage);
  }

  /// Gets the current locale based on settings.
  Locale getCurrentLocale(SettingsLoaded state) {
    return _getLocaleFromSettings(state);
  }
}

/// A widget that automatically updates MaterialApp locale based on settings.
class LocaleAwareAppBuilder extends StatelessWidget {
  /// The app widget to wrap.
  final Widget app;

  const LocaleAwareAppBuilder({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final locale = _getLocaleFromState(state);

        return Localizations.override(
          context: context,
          locale: locale,
          child: app,
        );
      },
    );
  }

  Locale? _getLocaleFromState(SettingsState state) {
    if (state is! SettingsLoaded) return null;

    final settings = state.settings;

    if (settings.useSystemLanguage) {
      return PlatformDispatcher.instance.locale;
    }

    return Locale(settings.appLanguage);
  }
}
