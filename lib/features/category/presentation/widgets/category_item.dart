import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/utils/icon_mapper.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';
import 'package:test_app/l10n/app_localizations.dart';

class CategoryItem extends StatelessWidget {
  final CategoryData category;
  final VoidCallback? onTap;

  const CategoryItem({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isIncome = category.type == 'income';

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      decoration: _buildContainerDecoration(),
      child: _buildListTile(isIncome),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppColors.surfaceDark,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      border: Border.all(
        color: AppColors.categoryBorder,
        width: AppDimensions.borderWidthThin,
      ),
    );
  }

  Widget _buildListTile(bool isIncome) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      leading: _buildCategoryIcon(),
      title: _buildCategoryTitle(),
      subtitle: _buildCategorySubtitle(isIncome),
      onTap: onTap,
    );
  }

  Widget _buildCategoryIcon() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
      decoration: BoxDecoration(
        color: Color(category.color).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: Icon(
        IconMapper.getIconData(category.icon),
        color: Color(category.color),
        size: AppDimensions.iconMedium,
      ),
    );
  }

  Widget _buildCategoryTitle() {
    return Text(
      category.name,
      style: const TextStyle(
        color: AppColors.categoryTitleText,
        fontSize: AppDimensions.fontSizeLarge,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildCategorySubtitle(bool isIncome) {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return Text(
          isIncome ? l10n.income : l10n.expense,
          style: TextStyle(
            color: isIncome ? AppColors.incomeStart : AppColors.expensesStart,
            fontSize: AppDimensions.fontSizeSmall,
          ),
        );
      },
    );
  }
}
