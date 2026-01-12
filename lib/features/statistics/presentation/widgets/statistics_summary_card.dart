import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/utils/currency_formatter.dart';
import 'package:test_app/features/statistics/domain/entities/statistics_data.dart';
import 'package:test_app/core/utils/period_formatter.dart';
import 'package:test_app/l10n/app_localizations.dart';

class StatisticsSummaryCard extends StatelessWidget {
  final StatisticsData statistics;

  const StatisticsSummaryCard({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: _buildContainerDecoration(),
      padding: const EdgeInsets.all(AppDimensions.cardPaddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodHeader(l10n),
          const SizedBox(height: AppDimensions.spacingMedium),
          _buildBalanceRow(),
          const SizedBox(height: AppDimensions.summaryCardBalanceSpacing),
          _buildIncomeExpenseRow(l10n),
        ],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      gradient: _buildGradient(),
      borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
      boxShadow: [_buildBoxShadow()],
    );
  }

  LinearGradient _buildGradient() {
    return const LinearGradient(
      colors: [AppColors.balanceStart, AppColors.balanceEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  BoxShadow _buildBoxShadow() {
    return BoxShadow(
      color: AppColors.balanceStart.withValues(alpha: 0.3),
      blurRadius: AppDimensions.summaryCardShadowBlurRadius,
      offset: const Offset(0, AppDimensions.summaryCardShadowOffsetY),
    );
  }

  Widget _buildPeriodHeader(AppLocalizations l10n) {
    return Text(
      l10n.summaryFor(PeriodFormatter.format(statistics.period)),
      style: const TextStyle(
        color: AppColors.summaryCardTextSecondary,
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildIncomeExpenseRow(AppLocalizations l10n) {
    return Row(
      children: [
        _buildIncomeItem(l10n),
        const SizedBox(width: AppDimensions.summaryCardItemSpacing),
        _buildExpenseItem(l10n),
      ],
    );
  }

  Widget _buildIncomeItem(AppLocalizations l10n) {
    return _buildSummaryItem(
      l10n.income,
      statistics.totalIncome,
      AppColors.incomeStart,
      Icons.arrow_downward,
    );
  }

  Widget _buildExpenseItem(AppLocalizations l10n) {
    return _buildSummaryItem(
      l10n.expense_plural,
      statistics.totalExpense,
      AppColors.expensesStart,
      Icons.arrow_upward,
    );
  }

  Widget _buildBalanceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildBalanceInfo(), _buildTrendIcon()],
    );
  }

  Widget _buildBalanceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBalanceTitle(),
        const SizedBox(height: AppDimensions.summaryCardBalanceTitleSpacing),
        _buildBalanceAmount(),
      ],
    );
  }

  Widget _buildBalanceTitle() {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return Text(
          l10n.netBalance,
          style: const TextStyle(
            color: AppColors.summaryCardText,
            fontSize: AppDimensions.fontSizeBalanceTitle,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }

  Widget _buildBalanceAmount() {
    return Text(
      CurrencyFormatter.format(statistics.balance, 'USD'),
      style: const TextStyle(
        color: AppColors.summaryCardText,
        fontSize: AppDimensions.fontSizeBalance,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTrendIcon() {
    final isPositive = statistics.balance >= 0;

    return Container(
      padding: const EdgeInsets.all(AppDimensions.summaryCardTrendIconPadding),
      decoration: _buildTrendIconDecoration(),
      child: _buildTrendIconWidget(isPositive),
    );
  }

  BoxDecoration _buildTrendIconDecoration() {
    return BoxDecoration(
      color: AppColors.summaryCardText.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
    );
  }

  Widget _buildTrendIconWidget(bool isPositive) {
    return Icon(
      isPositive ? Icons.trending_up : Icons.trending_down,
      color: AppColors.summaryCardText,
      size: AppDimensions.summaryCardIconSize,
    );
  }

  Widget _buildSummaryItem(
    String label,
    double amount,
    Color color,
    IconData icon,
  ) {
    return Expanded(child: _buildSummaryItemContainer(label, amount, icon));
  }

  Widget _buildSummaryItemContainer(
    String label,
    double amount,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: _buildSummaryItemDecoration(),
      child: _buildSummaryItemColumn(label, amount, icon),
    );
  }

  Widget _buildSummaryItemColumn(String label, double amount, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSummaryItemHeader(label, icon),
        const SizedBox(height: AppDimensions.summaryCardItemVerticalSpacing),
        _buildSummaryItemAmount(amount),
      ],
    );
  }

  BoxDecoration _buildSummaryItemDecoration() {
    return BoxDecoration(
      color: AppColors.summaryCardText.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
    );
  }

  Widget _buildSummaryItemHeader(String label, IconData icon) {
    return Row(
      children: [
        _buildSummaryItemIcon(icon),
        const SizedBox(width: AppDimensions.summaryCardItemIconSpacing),
        _buildSummaryItemLabel(label),
      ],
    );
  }

  Widget _buildSummaryItemIcon(IconData icon) {
    return Icon(
      icon,
      color: AppColors.summaryCardText,
      size: AppDimensions.summaryCardItemIconSize,
    );
  }

  Widget _buildSummaryItemLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.summaryCardTextSecondary,
        fontSize: AppDimensions.fontSizeSummaryItemLabel,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSummaryItemAmount(double amount) {
    return Text(
      CurrencyFormatter.format(amount, 'USD'),
      style: const TextStyle(
        color: AppColors.summaryCardText,
        fontSize: AppDimensions.fontSizeSummaryItemAmount,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
