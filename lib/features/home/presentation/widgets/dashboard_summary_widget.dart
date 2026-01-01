import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/features/home/domain/entities/dashboard_summary_data.dart';

class DashboardSummary extends StatelessWidget {
  final DashboardSummaryData summary;

  const DashboardSummary({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDashboardTitle(context),
        const SizedBox(height: AppDimensions.paddingLarge),
        _buildExpensesAndIncomeCards(context),
        const SizedBox(height: AppDimensions.paddingMedium),
        _buildBalanceCard(context),
      ],
    );
  }

  Widget _buildDashboardTitle(BuildContext context) {
    return Text(
      'Dashboard',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.sectionHeaderText,
      ),
    );
  }

  Widget _buildExpensesAndIncomeCards(BuildContext context) {
    return Row(
      children: [
        _buildExpensesCard(context),
        const SizedBox(width: AppDimensions.paddingMedium),
        _buildIncomeCard(context),
      ],
    );
  }

  Widget _buildExpensesCard(BuildContext context) {
    return Expanded(
      child: _buildSummaryCard(
        context: context,
        icon: Icons.trending_down,
        title: 'Expenses',
        amount: summary.totalExpenses,
        gradient: _buildExpensesGradient(),
      ),
    );
  }

  Widget _buildIncomeCard(BuildContext context) {
    return Expanded(
      child: _buildSummaryCard(
        context: context,
        icon: Icons.trending_up,
        title: 'Incomes',
        amount: summary.totalIncome,
        gradient: _buildIncomeGradient(),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return _buildSummaryCard(
      context: context,
      icon: Icons.account_balance_wallet_outlined,
      title: 'Balance',
      amount: summary.totalBalance,
      gradient: _buildBalanceGradient(),
      fullWidth: true,
    );
  }

  LinearGradient _buildBalanceGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.balanceStart, AppColors.balanceEnd],
    );
  }

  LinearGradient _buildIncomeGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.incomeStart, AppColors.incomeEnd],
    );
  }

  LinearGradient _buildExpensesGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.expensesStart, AppColors.expensesEnd],
    );
  }

  Widget _buildSummaryCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required double amount,
    required LinearGradient gradient,
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: _buildCardDecoration(gradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardIcon(icon),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildAmountText(context, amount, fullWidth),
          const SizedBox(height: AppDimensions.paddingSmall),
          _buildTitleText(context, title),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration(LinearGradient gradient) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(AppDimensions.radiusXXLarge),
      boxShadow: _buildCardBoxShadow(gradient),
    );
  }

  List<BoxShadow> _buildCardBoxShadow(LinearGradient gradient) {
    return [
      BoxShadow(
        color: gradient.colors.first.withValues(alpha: 0.3),
        blurRadius: AppDimensions.shadowBlurRadius,
        offset: const Offset(0, AppDimensions.shadowOffsetY),
      ),
    ];
  }

  Widget _buildCardIcon(IconData icon) {
    return Icon(
      icon,
      color: Colors.white.withValues(alpha: 0.9),
      size: AppDimensions.iconLarge,
    );
  }

  Widget _buildAmountText(BuildContext context, double amount, bool fullWidth) {
    return Text(
      '\$${amount.toStringAsFixed(2)}',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: fullWidth
            ? AppDimensions.fontSizeXXXLarge
            : AppDimensions.fontSizeTitle,
      ),
    );
  }

  Widget _buildTitleText(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.white.withValues(alpha: 0.9),
      ),
    );
  }
}
