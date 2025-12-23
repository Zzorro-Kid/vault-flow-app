import 'package:equatable/equatable.dart';

class AuthStateData extends Equatable {
  final bool isFirstLaunch;
  final bool hasPassword;

  const AuthStateData({
    required this.isFirstLaunch,
    required this.hasPassword,
  });

  @override
  List<Object?> get props => [isFirstLaunch, hasPassword];
}
