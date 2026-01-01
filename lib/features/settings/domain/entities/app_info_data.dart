import 'package:equatable/equatable.dart';

class AppInfoData extends Equatable {
  final String version;
  final String buildNumber;
  final String appName;

  const AppInfoData({
    required this.version,
    required this.buildNumber,
    required this.appName,
  });

  @override
  List<Object?> get props => [version, buildNumber, appName];
}
