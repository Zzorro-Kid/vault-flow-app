import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';

class EmptyTransactionsView extends StatelessWidget {
  const EmptyTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEmptyIcon(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildEmptyTitle(),
        ],
      ),
    );
  }

  Widget _buildEmptyIcon() {
    return const Icon(
      Icons.receipt_long_outlined,
      size: AppDimensions.iconXXLarge,
      color: AppColors.emptyStateIcon,
    );
  }

  Widget _buildEmptyTitle() {
    return const Text(
      'No transactions yet',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeXLarge,
        color: AppColors.emptyStateText,
      ),
    );
  }
}
