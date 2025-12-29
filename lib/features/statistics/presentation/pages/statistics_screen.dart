import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/utils/ui_helpers.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:test_app/features/statistics/presentation/widgets/statistics_app_bar.dart';
import 'package:test_app/features/statistics/presentation/widgets/statistics_error_view.dart';
import 'package:test_app/features/statistics/presentation/widgets/statistics_loaded_view.dart';
import 'package:test_app/injection_container.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<StatisticsCubit>()..loadStatistics(),
      child: BlocListener<StatisticsCubit, StatisticsState>(
        listener: (context, state) {
          switch (state) {
            case StatisticsError():
              UiHelpers.showErrorSnackBar(context, state.message);
            default:
              break;
          }
        },
        child: Scaffold(appBar: const StatisticsAppBar(), body: _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        return switch (state) {
          StatisticsLoading() => const LoadingIndicator(),
          StatisticsLoaded() => StatisticsLoadedView(
            statistics: state.statistics,
          ),
          StatisticsError() => StatisticsErrorView(
            message: state.message,
            onRetry: () => context.read<StatisticsCubit>().loadStatistics(),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
