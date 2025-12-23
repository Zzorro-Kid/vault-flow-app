import 'package:test_app/features/auth/domain/entities/auth_state_data.dart';

class AuthStateDataModel extends AuthStateData {
  const AuthStateDataModel({
    required super.isFirstLaunch,
    required super.hasPassword,
  });

  factory AuthStateDataModel.fromJson(Map<String, dynamic> json) {
    return AuthStateDataModel(
      isFirstLaunch: json['isFirstLaunch'] as bool? ?? true,
      hasPassword: json['hasPassword'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isFirstLaunch': isFirstLaunch,
      'hasPassword': hasPassword,
    };
  }

  AuthStateDataModel copyWith({
    bool? isFirstLaunch,
    bool? hasPassword,
  }) {
    return AuthStateDataModel(
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      hasPassword: hasPassword ?? this.hasPassword,
    );
  }

  factory AuthStateDataModel.initial() {
    return const AuthStateDataModel(
      isFirstLaunch: true,
      hasPassword: false,
    );
  }
}
