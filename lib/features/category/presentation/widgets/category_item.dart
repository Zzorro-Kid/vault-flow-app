import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';

class CategoryItem extends StatelessWidget {
  final CategoryData category;
  final VoidCallback onDelete;

  const CategoryItem({
    super.key,
    required this.category,
    required this.onDelete,
  });

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
      trailing: _buildDeleteButton(),
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
        _getIconData(category.icon),
        color: Color(category.color),
        size: AppDimensions.iconMedium,
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'restaurant':
        return Icons.restaurant;
      case 'directions_car':
        return Icons.directions_car;
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'movie':
        return Icons.movie;
      case 'local_hospital':
        return Icons.local_hospital;
      case 'account_balance_wallet':
        return Icons.account_balance_wallet;
      case 'work':
        return Icons.work;
      case 'trending_up':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
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
    return Text(
      isIncome ? 'Income' : 'Expense',
      style: TextStyle(
        color: isIncome ? AppColors.incomeStart : AppColors.expensesStart,
        fontSize: AppDimensions.fontSizeSmall,
      ),
    );
  }

  Widget _buildDeleteButton() {
    return IconButton(
      icon: const Icon(Icons.delete_outline, color: AppColors.expensesStart),
      onPressed: onDelete,
    );
  }
}
