import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
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
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: _buildAppBarBackground(),
      title: _buildAppBarTitle(),
      actions: [_buildLogoutButton(context)],
    );
  }

  Widget _buildAppBarBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 88, 90, 231), Color(0xFF8B5CF6)],
        ),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      children: [
        _buildLogoIcon(),
        const SizedBox(width: AppDimensions.radiusLarge),
        _buildAppName(),
      ],
    );
  }

  Widget _buildLogoIcon() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(
          AppDimensions.appBarIconContainerRadius,
        ),
      ),
      child: const Icon(
        Icons.shield_outlined,
        color: Colors.white,
        size: AppDimensions.iconMedium,
      ),
    );
  }

  Widget _buildAppName() {
    return const Text(
      'VaultFlow',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeXXLarge,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(
          AppDimensions.appBarIconContainerRadius,
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.logout_outlined, color: Colors.white),
        onPressed: () => Navigator.pushReplacementNamed(context, '/auth'),
        tooltip: 'Logout',
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
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardSummary(summary: summary),
            const SizedBox(height: AppDimensions.paddingXLarge),
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
          ],
        ),
      ),
    );
  }
}
