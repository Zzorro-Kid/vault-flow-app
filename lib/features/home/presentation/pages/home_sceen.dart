import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/utils/ui_helpers.dart';
import 'package:test_app/core/widgets/bottom_navigation_bar.dart';
import 'package:test_app/core/widgets/custom_app_bar.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/home/presentation/widgets/transactions_list.dart';
import 'package:test_app/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:test_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:test_app/features/home/presentation/widgets/dashboard_summary_widget.dart';
import 'package:test_app/features/transaction/domain/entities/transaction_data.dart';
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
          appBar: _buildAppBar(),
          body: _buildBody(),
          bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 0),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(title: _buildAppBarContent());
  }

  Widget _buildAppBarContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAppBarIcon(),
        const SizedBox(width: AppDimensions.radiusMedium),
        _buildAppBarTitle(),
      ],
    );
  }

  Widget _buildAppBarIcon() {
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

  Widget _buildAppBarTitle() {
    return const Text(
      'VaultFlow',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeXXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.categoryTitleText,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeLoading ||
          current is HomeLoaded ||
          current is HomeInitial,
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
    DashboardSummaryData summary,
    List<TransactionData> recentTransactions,
  ) {
    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().refreshHomeData(),
      child: CustomScrollView(
        slivers: [
          _buildDashboardSection(summary),
          _buildRecentTransactionsSection(recentTransactions),
        ],
      ),
    );
  }

  Widget _buildDashboardSection(DashboardSummaryData summary) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: DashboardSummary(summary: summary),
      ),
    );
  }

  Widget _buildRecentTransactionsSection(
    List<TransactionData> recentTransactions,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: AppDimensions.paddingLarge),
      sliver: TransactionsList(transactions: recentTransactions),
    );
  }
}
