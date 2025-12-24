import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/core/domain/entities/transaction_data.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';

class TransactionsList extends StatelessWidget {
  final List<TransactionData> transactions;

  const TransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return _buildEmptyState(context);
    }

    return _buildTransactionsList(context);
  }

  Widget _buildEmptyState(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Colors.white.withValues(alpha: 0.3),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Text(
              'No transactions yet',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsList(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final tx = transactions[index];
          return _buildTransactionItem(context, tx);
        }, childCount: transactions.length),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, TransactionData tx) {
    final isIncome = tx.type == 'income';

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      decoration: _buildItemDecoration(),
      child: ListTile(
        contentPadding: _buildItemContentPadding(),
        leading: _buildCategoryIcon(tx.category.icon, isIncome),
        title: _buildDescriptionText(context, tx.description),
        subtitle: _buildCategoryAndDateText(context, tx),
        trailing: _buildAmountText(context, tx.amount, isIncome),
      ),
    );
  }

  BoxDecoration _buildItemDecoration() {
    return BoxDecoration(
      color: AppColors.surfaceDark,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
    );
  }

  EdgeInsets _buildItemContentPadding() {
    return const EdgeInsets.symmetric(
      horizontal: AppDimensions.paddingMedium,
      vertical: AppDimensions.paddingSmall,
    );
  }

  Widget _buildCategoryIcon(String iconName, bool isIncome) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isIncome
            ? AppColors.incomeStart.withValues(alpha: 0.2)
            : AppColors.expensesStart.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        _getCategoryIcon(iconName),
        color: isIncome ? AppColors.incomeStart : AppColors.expensesStart,
        size: 24,
      ),
    );
  }

  Widget _buildDescriptionText(BuildContext context, String description) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildCategoryAndDateText(BuildContext context, TransactionData tx) {
    final dateFormat = DateFormat('MMM dd');

    return Text(
      '${tx.category.name} • ${dateFormat.format(tx.date)}',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.white.withValues(alpha: 0.6),
      ),
    );
  }

  Widget _buildAmountText(BuildContext context, double amount, bool isIncome) {
    return Text(
      '${isIncome ? '+' : '-'}\$${amount.toStringAsFixed(2)}',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: isIncome ? AppColors.incomeStart : AppColors.expensesStart,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'music':
        return Icons.music_note;
      case 'shopping':
        return Icons.shopping_cart;
      case 'work':
        return Icons.work;
      case 'coffee':
        return Icons.coffee;
      case 'restaurant':
        return Icons.restaurant;
      case 'transport':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      default:
        return Icons.category;
    }
  }
}
