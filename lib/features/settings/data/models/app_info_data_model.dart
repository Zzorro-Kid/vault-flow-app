import 'package:test_app/features/settings/domain/entities/app_info_data.dart';

class AppInfoDataModel extends AppInfoData {
  const AppInfoDataModel({
    required super.version,
    required super.buildNumber,
    required super.appName,
  });

  factory AppInfoDataModel.fromJson(Map<String, dynamic> json) {
    return AppInfoDataModel(
      version: json['version'] as String,
      buildNumber: json['build_number'] as String,
      appName: json['app_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'build_number': buildNumber,
      'app_name': appName,
    };
  }
}
