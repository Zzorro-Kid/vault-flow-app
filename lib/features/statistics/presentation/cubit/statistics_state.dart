part of 'statistics_cubit.dart';

sealed class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object?> get props => [];
}

final class StatisticsInitial extends StatisticsState {
  const StatisticsInitial();
}

final class StatisticsLoading extends StatisticsState {
  const StatisticsLoading();
}

final class StatisticsLoaded extends StatisticsState {
  final StatisticsData statistics;

  const StatisticsLoaded({required this.statistics});

  @override
  List<Object?> get props => [statistics];
}

final class StatisticsError extends StatisticsState {
  final String message;

  const StatisticsError(this.message);

  @override
  List<Object?> get props => [message];
}
