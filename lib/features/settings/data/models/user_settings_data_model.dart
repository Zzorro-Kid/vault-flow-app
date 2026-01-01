import 'package:test_app/features/settings/domain/entities/user_settings_data.dart';

class UserSettingsDataModel extends UserSettingsData {
  const UserSettingsDataModel({
    required super.currency,
    required super.reportFrequency,
    required super.userId,
  });

  factory UserSettingsDataModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsDataModel(
      currency: json['currency'] as String,
      reportFrequency: json['report_frequency'] as String,
      userId: json['user_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'report_frequency': reportFrequency,
      'user_id': userId,
    };
  }

  UserSettingsDataModel copyWith({
    String? currency,
    String? reportFrequency,
    String? userId,
  }) {
    return UserSettingsDataModel(
      currency: currency ?? this.currency,
      reportFrequency: reportFrequency ?? this.reportFrequency,
      userId: userId ?? this.userId,
    );
  }
}
