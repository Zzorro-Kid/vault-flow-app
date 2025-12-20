import 'package:test_app/features/auth/domain/entities/auth_state_data.dart';

class AuthStateDataModel extends AuthStateData {
  const AuthStateDataModel({
    required super.isFirstLaunch,
    required super.hasPassword,
    required super.useBiometric,
  });

  factory AuthStateDataModel.fromJson(Map<String, dynamic> json) {
    return AuthStateDataModel(
      isFirstLaunch: json['isFirstLaunch'] as bool? ?? true,
      hasPassword: json['hasPassword'] as bool? ?? false,
      useBiometric: json['useBiometric'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isFirstLaunch': isFirstLaunch,
      'hasPassword': hasPassword,
      'useBiometric': useBiometric,
    };
  }

  AuthStateDataModel copyWith({
    bool? isFirstLaunch,
    bool? hasPassword,
    bool? useBiometric,
  }) {
    return AuthStateDataModel(
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      hasPassword: hasPassword ?? this.hasPassword,
      useBiometric: useBiometric ?? this.useBiometric,
    );
  }

  factory AuthStateDataModel.initial() {
    return const AuthStateDataModel(
      isFirstLaunch: true,
      hasPassword: false,
      useBiometric: false,
    );
  }
}
