import 'package:equatable/equatable.dart';

class UserSettingsData extends Equatable {
  final String currency;
  final String reportFrequency;
  final String userId;
  final String appLanguage;
  final bool useSystemLanguage;

  // Supported languages constants
  static const String languageEnglish = 'en';
  static const String languageRussian = 'ru';
  static const String languageUkrainian = 'uk';
  static const String languageGerman = 'de';
  static const String languageFrench = 'fr';

  static const List<String> supportedLanguages = [
    languageEnglish,
    languageRussian,
    languageUkrainian,
    languageGerman,
    languageFrench,
  ];

  const UserSettingsData({
    required this.currency,
    required this.reportFrequency,
    required this.userId,
    this.appLanguage = languageEnglish,
    this.useSystemLanguage = true,
  });

  @override
  List<Object?> get props => [
    currency,
    reportFrequency,
    userId,
    appLanguage,
    useSystemLanguage,
  ];
}
