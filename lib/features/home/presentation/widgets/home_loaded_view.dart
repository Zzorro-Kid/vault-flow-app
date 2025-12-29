import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/widgets/transactions_list_widget.dart';
import 'package:test_app/features/transaction/domain/entities/transaction_data.dart';
import 'package:test_app/features/home/domain/entities/dashboard_summary_data.dart';
import 'package:test_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:test_app/features/home/presentation/widgets/dashboard_summary_widget.dart';

class HomeLoadedView extends StatelessWidget {
  final DashboardSummaryData summary;
  final List<TransactionData> recentTransactions;

  const HomeLoadedView({
    super.key,
    required this.summary,
    required this.recentTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().refreshHomeData(),
      child: CustomScrollView(
        slivers: [
          _buildDashboardSection(),
          _buildRecentTransactionsSection(),
        ],
      ),
    );
  }

  Widget _buildDashboardSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: DashboardSummary(summary: summary),
      ),
    );
  }

  Widget _buildRecentTransactionsSection() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: AppDimensions.paddingLarge),
      sliver: TransactionsList(transactions: recentTransactions),
    );
  }
}