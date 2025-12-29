import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/features/transaction/domain/entities/transaction_data.dart';

class TransactionItem extends StatelessWidget {
  final TransactionData transaction;
  final VoidCallback? onTap;

  const TransactionItem({super.key, required this.transaction, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      child: _buildTransactionCard(),
    );
  }

  Widget _buildTransactionCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: _buildContainerDecoration(),
      child: _buildTransactionRow(),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppColors.surfaceDark,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
    );
  }

  Widget _buildTransactionRow() {
    return Row(
      children: [
        Expanded(child: _buildTransactionInfo()),
        _buildAmountText(),
      ],
    );
  }

  Widget _buildTransactionInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDescriptionText(),
        const SizedBox(height: AppDimensions.paddingXSmall),
        _buildCategoryText(),
      ],
    );
  }

  Widget _buildDescriptionText() {
    return Text(
      transaction.description,
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.categoryTitleText,
      ),
    );
  }

  Widget _buildCategoryText() {
    return Text(
      transaction.category.name,
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        color: AppColors.sectionHeaderText,
      ),
    );
  }

  Widget _buildAmountText() {
    return Text(
      '\$${transaction.amount.toStringAsFixed(2)}',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeLarge,
        fontWeight: FontWeight.bold,
        color: transaction.type == 'income'
            ? AppColors.incomeStart
            : AppColors.expensesStart,
      ),
    );
  }
}
