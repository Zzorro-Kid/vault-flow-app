import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/l10n/app_localizations.dart';

class StatisticsErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const StatisticsErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildErrorIcon(),
          const SizedBox(height: AppDimensions.spacingMedium),
          _buildErrorMessage(),
          const SizedBox(height: AppDimensions.spacingLarge),
          _buildRetryButton(l10n),
        ],
      ),
    );
  }

  Widget _buildErrorIcon() {
    return const Icon(
      Icons.error_outline,
      size: AppDimensions.emptyStateIconSize,
      color: AppColors.error,
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: AppDimensions.fontSizeLarge),
    );
  }

  Widget _buildRetryButton(AppLocalizations l10n) {
    return ElevatedButton.icon(
      onPressed: onRetry,
      icon: const Icon(Icons.refresh),
      label: Text(l10n.retry),
    );
  }
}
