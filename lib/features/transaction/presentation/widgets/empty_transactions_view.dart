import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/l10n/app_localizations.dart';

class EmptyTransactionsView extends StatelessWidget {
  const EmptyTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEmptyIcon(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildEmptyTitle(l10n),
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

  Widget _buildEmptyTitle(AppLocalizations l10n) {
    return Text(
      l10n.noTransactionsYet,
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeXLarge,
        color: AppColors.emptyStateText,
      ),
    );
  }
}
