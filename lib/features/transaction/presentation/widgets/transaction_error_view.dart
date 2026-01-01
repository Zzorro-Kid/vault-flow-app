import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';

class TransactionErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const TransactionErrorView({
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
      color: AppColors.error,
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      message,
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeLarge,
        color: AppColors.sectionHeaderText,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildRetryButton() {
    return ElevatedButton(
      onPressed: onRetry,
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
      child: const Text('Retry'),
    );
  }
}
