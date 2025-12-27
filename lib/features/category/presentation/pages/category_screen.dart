import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/core/utils/ui_helpers.dart';
import 'package:test_app/core/widgets/bottom_navigation_bar.dart';
import 'package:test_app/core/widgets/custom_app_bar.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';
import 'package:test_app/features/category/presentation/cubit/category_cubit.dart';
import 'package:test_app/features/category/presentation/cubit/category_state.dart';
import 'package:test_app/features/category/presentation/widgets/add_category_dialog.dart';
import 'package:test_app/features/category/presentation/widgets/category_error_view.dart';
import 'package:test_app/features/category/presentation/widgets/category_item.dart';
import 'package:test_app/features/category/presentation/widgets/edit_category_dialog.dart';
import 'package:test_app/features/category/presentation/widgets/empty_categories_view.dart';
import 'package:test_app/injection_container.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoryCubit>()..loadCategories(),
      child: BlocListener<CategoryCubit, CategoryState>(
        listener: (context, state) {
          switch (state) {
            case CategoryError():
              UiHelpers.showErrorSnackBar(context, state.message);
            case CategoryOperationSuccess():
              _showOperationSnackBar(context, state.message);
            default:
              break;
          }
        },
        child: Scaffold(
          appBar: _buildAppBar(),
          body: Stack(children: [_buildBody(), _buildFloatingActionButton()]),
          bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 2),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: AppDimensions.appBarHeightOther,
      topPadding: AppDimensions.appBarTopPadding,
      title: Transform.translate(
        offset: const Offset(0, AppDimensions.appBarTitleOffsetY),
        child: const Text(
          'Categories',
          style: TextStyle(
            fontSize: AppDimensions.fontSizeXXLarge,
            fontWeight: FontWeight.bold,
            color: AppColors.categoryTitleText,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return switch (state) {
          CategoryLoading() => const LoadingIndicator(),
          CategoryLoaded() => _buildCategoryList(state.categories),
          CategoryError() => CategoryErrorView(
            message: state.message,
            onRetry: () => context.read<CategoryCubit>().loadCategories(),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildCategoryList(List<CategoryData> categories) {
    if (categories.isEmpty) {
      return const EmptyCategoriesView();
    }

    final expenseCategories = _filterCategoriesByType(categories, 'expense');
    final incomeCategories = _filterCategoriesByType(categories, 'income');

    return CustomScrollView(
      slivers: [
        if (expenseCategories.isNotEmpty)
          ..._buildCategorySection('Expense Categories', expenseCategories),
        if (incomeCategories.isNotEmpty)
          ..._buildCategorySection('Income Categories', incomeCategories),
      ],
    );
  }

  List<CategoryData> _filterCategoriesByType(
    List<CategoryData> categories,
    String type,
  ) {
    return categories.where((c) => c.type == type).toList();
  }

  List<Widget> _buildCategorySection(
    String title,
    List<CategoryData> categories,
  ) {
    return [
      _buildSectionHeaderSliver(title),
      _buildCategoryListSliver(categories),
    ];
  }

  Widget _buildSectionHeaderSliver(String title) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingMedium,
        AppDimensions.paddingLarge,
        AppDimensions.paddingMedium,
        AppDimensions.paddingSmall,
      ),
      sliver: SliverToBoxAdapter(child: _buildSectionHeader(title)),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.sectionHeaderText,
      ),
    );
  }

  Widget _buildCategoryListSliver(List<CategoryData> categories) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Dismissible(
            key: Key(categories[index].id),
            direction: DismissDirection.endToStart,
            background: _buildDismissBackground(),
            confirmDismiss: (direction) =>
                _confirmDelete(context, categories[index]),
            child: CategoryItem(
              category: categories[index],
              onTap: () => _showEditCategoryDialog(context, categories[index]),
            ),
          ),
          childCount: categories.length,
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      right: AppDimensions.paddingMedium,
      bottom: AppDimensions.paddingMedium,
      child: Builder(
        builder: (builderContext) => FloatingActionButton(
          onPressed: () => _showAddCategoryDialog(builderContext),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AddCategoryDialog(
        onAdd: (category) {
          context.read<CategoryCubit>().addCategory(category);
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  void _showEditCategoryDialog(BuildContext context, CategoryData category) {
    showDialog(
      context: context,
      builder: (dialogContext) => EditCategoryDialog(
        category: category,
        onSave: (updatedCategory) {
          context.read<CategoryCubit>().updateCategory(updatedCategory);
          Navigator.pop(dialogContext);
        },
      ),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: const Icon(
        Icons.delete_outline,
        color: Colors.white,
        size: AppDimensions.iconLarge,
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context, CategoryData category) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: _buildDeleteDialogTitle(),
        content: _buildDeleteDialogContent(category.name),
        actions: _buildDeleteDialogActions(dialogContext, context, category.id),
      ),
    );
  }

  Widget _buildDeleteDialogTitle() {
    return const Text(
      'Delete Category',
      style: TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildDeleteDialogContent(String categoryName) {
    return Text(
      'Are you sure you want to delete "$categoryName"?',
      style: const TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  List<Widget> _buildDeleteDialogActions(
    BuildContext dialogContext,
    BuildContext parentContext,
    String categoryId,
  ) {
    return [
      _buildCancelButton(dialogContext),
      _buildDeleteButton(dialogContext, parentContext, categoryId),
    ];
  }

  Widget _buildCancelButton(BuildContext dialogContext) {
    return TextButton(
      onPressed: () => Navigator.pop(dialogContext, false),
      child: const Text('Cancel'),
    );
  }

  Widget _buildDeleteButton(
    BuildContext dialogContext,
    BuildContext parentContext,
    String categoryId,
  ) {
    return TextButton(
      onPressed: () {
        parentContext.read<CategoryCubit>().deleteCategory(categoryId);
        Navigator.pop(dialogContext, true);
      },
      child: const Text(
        'Delete',
        style: TextStyle(color: AppColors.expensesStart),
      ),
    );
  }

  void _showOperationSnackBar(BuildContext context, String message) {
    final backgroundColor = _getSnackBarColor(message);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }

  Color _getSnackBarColor(String message) {
    final operationType = _getOperationType(message);

    switch (operationType) {
      case 'deleted':
        return AppColors.error;
      case 'updated':
        return AppColors.primary;
      case 'added':
      default:
        return AppColors.incomeStart;
    }
  }

  String _getOperationType(String message) {
    final lowerMessage = message.toLowerCase();
    if (lowerMessage.contains('deleted')) return 'deleted';
    if (lowerMessage.contains('updated')) return 'updated';
    return 'added';
  }
}
