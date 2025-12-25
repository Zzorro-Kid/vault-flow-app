import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';

class CategoryErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CategoryErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildErrorIcon(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildErrorMessage(),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildRetryButton(),
        ],
      ),
    );
  }

  Widget _buildErrorIcon() {
    return const Icon(
      Icons.error_outline,
      size: AppDimensions.iconXXLarge,
      color: AppColors.expensesStart,
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeLarge,
        color: AppColors.sectionHeaderText,
      ),
    );
  }

  Widget _buildRetryButton() {
    return ElevatedButton(onPressed: onRetry, child: const Text('Retry'));
  }
}
