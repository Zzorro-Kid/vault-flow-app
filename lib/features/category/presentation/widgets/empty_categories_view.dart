import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/l10n/app_localizations.dart';

class EmptyCategoriesView extends StatelessWidget {
  const EmptyCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEmptyIcon(),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildEmptyMessage(context),
        ],
      ),
    );
  }

  Widget _buildEmptyIcon() {
    return const Icon(
      Icons.category_outlined,
      size: AppDimensions.iconXXLarge,
      color: AppColors.emptyStateIcon,
    );
  }

  Widget _buildEmptyMessage(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.noCategoriesYet,
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeXLarge,
        color: AppColors.emptyStateText,
      ),
    );
  }
}
