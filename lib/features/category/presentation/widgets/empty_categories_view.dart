import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';

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
          _buildEmptyMessage(),
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

  Widget _buildEmptyMessage() {
    return const Text(
      'No categories yet',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeXLarge,
        color: AppColors.emptyStateText,
      ),
    );
  }
}
