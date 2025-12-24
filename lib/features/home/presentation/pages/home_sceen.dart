import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:test_app/features/home/presentation/widgets/dashboard_summary_widget.dart';
import 'package:test_app/core/widgets/transactions_list_widget.dart';
import 'package:test_app/injection_container.dart';
import 'package:test_app/core/utils/ui_helpers.dart';

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
        child: Scaffold(appBar: _buildAppBar(context), body: _buildBody()),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('VaultFlow'),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => Navigator.pushReplacementNamed(context, '/auth'),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return switch (state) {
          HomeLoading() ||
          HomeInitial() => const LoadingIndicator(message: 'Loading...'),
          HomeLoaded(:final summary, :final recentTransactions) =>
            _buildLoadedContent(context, summary, recentTransactions),
          _ => const Center(child: Text('Something went wrong')),
        };
      },
    );
  }

  Widget _buildLoadedContent(
    BuildContext context,
    summary,
    recentTransactions,
  ) {
    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().refreshHomeData(),
      child: CustomScrollView(
        slivers: [
          _buildDashboardSection(context, summary),
          TransactionsList(transactions: recentTransactions),
        ],
      ),
    );
  }

  Widget _buildDashboardSection(BuildContext context, summary) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardSummary(summary: summary),
            const SizedBox(height: 24),
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
