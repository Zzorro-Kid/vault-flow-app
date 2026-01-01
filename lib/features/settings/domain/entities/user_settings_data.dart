import 'package:equatable/equatable.dart';

class UserSettingsData extends Equatable {
  final String currency;
  final String reportFrequency;
  final String userId;

  const UserSettingsData({
    required this.currency,
    required this.reportFrequency,
    required this.userId,
  });

  @override
  List<Object?> get props => [currency, reportFrequency, userId];
}
