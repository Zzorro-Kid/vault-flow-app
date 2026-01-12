import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:test_app/core/routes/app_routes.dart';
import 'package:test_app/core/constants/app_theme.dart';
import 'package:test_app/core/services/locale_service.dart';
import 'package:test_app/injection_container.dart';
import 'package:test_app/l10n/app_localizations.dart';
import 'package:test_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  // Initialize locale service early to determine initial locale
  final prefs = await SharedPreferences.getInstance();
  final localeService = LocaleService(prefs: prefs);
  final initialLocale = await localeService.determineInitialLocale();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(initialLocale: initialLocale),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _currentLocale;

  @override
  void initState() {
    super.initState();
    _currentLocale = widget.initialLocale;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<SettingsCubit>(),
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsLanguageChanged) {
            final newLocale = Locale(state.languageCode);
            if (newLocale != _currentLocale && mounted) {
              setState(() {
                _currentLocale = newLocale;
              });
            }
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'VaultFlow',
          locale: _currentLocale ?? widget.initialLocale,
          builder: DevicePreview.appBuilder,
          theme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          onGenerateRoute: AppRouter().onGenerateRoute,
          initialRoute: AppRouter.auth,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
