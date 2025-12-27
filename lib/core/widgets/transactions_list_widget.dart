import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/features/add_transaction/data/models/transaction_data.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';

class TransactionsList extends StatelessWidget {
  final List<TransactionData> transactions;

  const TransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return _buildTransactionsList(context);
  }

  Widget _buildTransactionsList(BuildContext context) {
    if (transactions.isEmpty) {
      return _buildEmptyTransactionsList(context);
    }
    return _buildPopulatedTransactionsList(context);
  }

  Widget _buildEmptyTransactionsList(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          _buildHeader(context),
          _buildEmptyStateContent(context),
        ]),
      ),
    );
  }

  Widget _buildPopulatedTransactionsList(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index == 0) {
            return _buildHeader(context);
          }
          final tx = transactions[index - 1];
          return _buildTransactionItem(context, tx);
        }, childCount: transactions.length + 1),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      child: _buildRecentTransactionsTitle(context),
    );
  }

  Widget _buildRecentTransactionsTitle(BuildContext context) {
    return Text(
      'Recent Transactions',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.categoryTitleText,
      ),
    );
  }

  Widget _buildEmptyStateContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingXLarge,
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: AppDimensions.iconXXLarge,
            color: AppColors.emptyStateIcon,
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          Text(
            'No transactions yet',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.emptyStateText),
          ),
        ],
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
      borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
      border: Border.all(
        color: AppColors.transactionBorder,
        width: AppDimensions.borderWidthThin,
      ),
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
      padding: const EdgeInsets.all(AppDimensions.radiusLarge),
      decoration: BoxDecoration(
        color: isIncome
            ? AppColors.incomeStart.withValues(alpha: 0.2)
            : AppColors.expensesStart.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: Icon(
        _getCategoryIcon(iconName),
        color: isIncome ? AppColors.incomeStart : AppColors.expensesStart,
        size: AppDimensions.iconMedium,
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

  Widget _buildDescriptionText(BuildContext context, String description) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.transactionDescriptionText,
      ),
    );
  }

  Widget _buildCategoryAndDateText(BuildContext context, TransactionData tx) {
    final dateFormat = DateFormat('MMM dd');

    return Text(
      '${tx.category.name} • ${dateFormat.format(tx.date)}',
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: AppColors.transactionSubtitleText),
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
}
