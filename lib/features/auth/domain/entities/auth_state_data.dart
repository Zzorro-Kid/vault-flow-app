import 'package:equatable/equatable.dart';

class AuthStateData extends Equatable {
  final bool isFirstLaunch;
  final bool hasPassword;
  final bool useBiometric;

  const AuthStateData({
    required this.isFirstLaunch,
    required this.hasPassword,
    required this.useBiometric,
  });

  @override
  List<Object?> get props => [isFirstLaunch, hasPassword, useBiometric];
}
