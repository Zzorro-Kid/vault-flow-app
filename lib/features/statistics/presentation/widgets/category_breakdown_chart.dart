import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/core/utils/currency_formatter.dart';
import 'package:test_app/features/statistics/domain/entities/category_breakdown_data.dart';
import 'package:test_app/core/utils/category_icon_mapper.dart';

class CategoryBreakdownChart extends StatelessWidget {
  final List<CategoryBreakdownData> categoryBreakdown;

  const CategoryBreakdownChart({super.key, required this.categoryBreakdown});

  @override
  Widget build(BuildContext context) {
    if (categoryBreakdown.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      decoration: _buildContainerDecoration(),
      padding: const EdgeInsets.all(AppDimensions.cardPaddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: AppDimensions.spacingMedium),
          ..._buildCategoryList(),
        ],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: AppDimensions.shadowBlurRadius,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Category Breakdown',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryLight,
      ),
    );
  }

  List<Widget> _buildCategoryList() {
    return categoryBreakdown
        .map((breakdown) => _buildCategoryItem(breakdown))
        .toList();
  }

  Widget _buildCategoryItem(CategoryBreakdownData breakdown) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryHeader(breakdown),
          const SizedBox(height: AppDimensions.spacingSmall),
          _buildProgressBar(breakdown),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(CategoryBreakdownData breakdown) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCategoryInfo(breakdown),
        _buildCategoryAmount(breakdown),
      ],
    );
  }

  Widget _buildCategoryInfo(CategoryBreakdownData breakdown) {
    return Row(
      children: [
        _buildCategoryIcon(breakdown),
        const SizedBox(width: AppDimensions.spacingLarge),
        _buildCategoryDetails(breakdown),
      ],
    );
  }

  Widget _buildCategoryIcon(CategoryBreakdownData breakdown) {
    return Container(
      width: AppDimensions.categoryIconSize,
      height: AppDimensions.categoryIconSize,
      decoration: _buildCategoryIconDecoration(breakdown),
      child: _buildCategoryIconWidget(breakdown),
    );
  }

  BoxDecoration _buildCategoryIconDecoration(CategoryBreakdownData breakdown) {
    return BoxDecoration(
      color: Color(breakdown.category.color).withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(AppDimensions.categoryIconRadius),
    );
  }

  Widget _buildCategoryIconWidget(CategoryBreakdownData breakdown) {
    return Icon(
      CategoryIconMapper.getIconData(breakdown.category.icon),
      color: Color(breakdown.category.color),
      size: AppDimensions.iconSmall + 4,
    );
  }

  Widget _buildCategoryDetails(CategoryBreakdownData breakdown) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryName(breakdown),
        _buildTransactionCount(breakdown),
      ],
    );
  }

  Widget _buildCategoryName(CategoryBreakdownData breakdown) {
    return Text(
      breakdown.category.name,
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeMedium + 1,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryLight,
      ),
    );
  }

  Widget _buildTransactionCount(CategoryBreakdownData breakdown) {
    return Text(
      '${breakdown.transactionCount} transaction${breakdown.transactionCount > 1 ? 's' : ''}',
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        color: AppColors.textSecondaryLight,
      ),
    );
  }

  Widget _buildCategoryAmount(CategoryBreakdownData breakdown) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildAmountText(breakdown),
        _buildPercentageText(breakdown),
      ],
    );
  }

  Widget _buildAmountText(CategoryBreakdownData breakdown) {
    return Text(
      CurrencyFormatter.format(breakdown.amount, 'USD'),
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeMedium + 1,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryLight,
      ),
    );
  }

  Widget _buildPercentageText(CategoryBreakdownData breakdown) {
    return Text(
      '${breakdown.percentage.toStringAsFixed(1)}%',
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        color: AppColors.textSecondaryLight,
      ),
    );
  }

  Widget _buildProgressBar(CategoryBreakdownData breakdown) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      child: _buildProgressIndicator(breakdown),
    );
  }

  Widget _buildProgressIndicator(CategoryBreakdownData breakdown) {
    return LinearProgressIndicator(
      value: breakdown.percentage / 100,
      backgroundColor: AppColors.progressBarBackground,
      valueColor: AlwaysStoppedAnimation<Color>(
        Color(breakdown.category.color),
      ),
      minHeight: AppDimensions.progressBarMinHeight,
    );
  }

  Widget _buildEmptyState() {
    return Container(
      decoration: _buildContainerDecoration(),
      padding: const EdgeInsets.all(AppDimensions.emptyStatePadding),
      child: Center(child: _buildEmptyStateContent()),
    );
  }

  Widget _buildEmptyStateContent() {
    return Column(
      children: [
        _buildEmptyStateIcon(),
        const SizedBox(height: AppDimensions.spacingMedium),
        _buildEmptyStateText(),
      ],
    );
  }

  Widget _buildEmptyStateIcon() {
    return const Icon(
      Icons.pie_chart_outline,
      size: AppDimensions.emptyStateIconSize,
      color: AppColors.emptyStateIconGrey,
    );
  }

  Widget _buildEmptyStateText() {
    return const Text(
      'No category data available',
      style: TextStyle(
        fontSize: AppDimensions.fontSizeLarge,
        color: AppColors.emptyStateTextGrey,
      ),
    );
  }
}
