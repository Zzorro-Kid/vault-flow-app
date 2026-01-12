import 'package:test_app/features/settings/domain/entities/user_settings_data.dart';

class UserSettingsDataModel extends UserSettingsData {
  const UserSettingsDataModel({
    required super.currency,
    required super.reportFrequency,
    required super.userId,
    super.appLanguage = UserSettingsData.languageEnglish,
    super.useSystemLanguage = true,
  });

  factory UserSettingsDataModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsDataModel(
      currency: json['currency'] as String,
      reportFrequency: json['report_frequency'] as String,
      userId: json['user_id'] as String,
      appLanguage:
          json['app_language'] as String? ?? UserSettingsData.languageEnglish,
      useSystemLanguage: json['use_system_language'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'report_frequency': reportFrequency,
      'user_id': userId,
      'app_language': appLanguage,
      'use_system_language': useSystemLanguage,
    };
  }

  UserSettingsDataModel copyWith({
    String? currency,
    String? reportFrequency,
    String? userId,
    String? appLanguage,
    bool? useSystemLanguage,
  }) {
    return UserSettingsDataModel(
      currency: currency ?? this.currency,
      reportFrequency: reportFrequency ?? this.reportFrequency,
      userId: userId ?? this.userId,
      appLanguage: appLanguage ?? this.appLanguage,
      useSystemLanguage: useSystemLanguage ?? this.useSystemLanguage,
    );
  }
}
