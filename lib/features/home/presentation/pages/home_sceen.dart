import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/utils/ui_helpers.dart';
import 'package:test_app/core/widgets/bottom_navigation_bar.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:test_app/features/home/presentation/widgets/home_app_bar.dart';
import 'package:test_app/features/home/presentation/widgets/home_loaded_view.dart';
import 'package:test_app/injection_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..loadHomeData(),
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          switch (state) {
            case HomeError():
              UiHelpers.showErrorSnackBar(context, state.message);
            default:
              break;
          }
        },
        child: Scaffold(
          appBar: const HomeAppBar(),
          body: _buildBody(),
          bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 0),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return switch (state) {
          HomeLoading() ||
          HomeInitial() => const LoadingIndicator(message: 'Loading...'),
          HomeLoaded(:final summary, :final recentTransactions) =>
            HomeLoadedView(
              summary: summary,
              recentTransactions: recentTransactions,
            ),
          _ => const Center(child: Text('Something went wrong')),
        };
      },
    );
  }
}
