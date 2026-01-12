import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/utils/list_helpers.dart';
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
import 'package:test_app/l10n/app_localizations.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoryCubit>()..loadCategories(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Stack(
          children: [_buildBody(), _buildFloatingActionButton(context)],
        ),
        bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 2),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(title: _buildAppBarTitle());
  }

  Widget _buildAppBarTitle() {
    return Builder(
      builder: (context) {
        return Text(
          AppLocalizations.of(context)!.categoriesTitle,
          style: const TextStyle(
            fontSize: AppDimensions.fontSizeXXLarge,
            fontWeight: FontWeight.bold,
            color: AppColors.categoryTitleText,
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      buildWhen: (previous, current) =>
          current is CategoryLoading ||
          current is CategoryLoaded ||
          current is CategoryError,
      builder: (context, state) {
        return switch (state) {
          CategoryLoading() => const LoadingIndicator(),
          CategoryLoaded() => _buildLoadedView(context, state.categories),
          CategoryError() => CategoryErrorView(
            message: state.message,
            onRetry: () => context.read<CategoryCubit>().loadCategories(),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildLoadedView(BuildContext context, List<CategoryData> categories) {
    if (categories.isEmpty) {
      return const EmptyCategoriesView();
    }

    return _buildCategoriesScrollView(context, categories);
  }

  Widget _buildCategoriesScrollView(
    BuildContext context,
    List<CategoryData> categories,
  ) {
    final expenseCategories = _getExpenseCategories(categories);
    final incomeCategories = _getIncomeCategories(categories);

    return CustomScrollView(
      slivers: _buildCategorySlivers(
        context,
        expenseCategories,
        incomeCategories,
      ),
    );
  }

  List<CategoryData> _getExpenseCategories(List<CategoryData> categories) {
    return _filterCategoriesByType(categories, 'expense');
  }

  List<CategoryData> _getIncomeCategories(List<CategoryData> categories) {
    return _filterCategoriesByType(categories, 'income');
  }

  List<Widget> _buildCategorySlivers(
    BuildContext context,
    List<CategoryData> expenseCategories,
    List<CategoryData> incomeCategories,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return [
      if (expenseCategories.isNotEmpty)
        ..._buildCategorySection(
          context,
          l10n.expenseCategories,
          expenseCategories,
        ),
      if (incomeCategories.isNotEmpty)
        ..._buildCategorySection(
          context,
          l10n.incomeCategories,
          incomeCategories,
        ),
    ];
  }

  List<CategoryData> _filterCategoriesByType(
    List<CategoryData> categories,
    String type,
  ) {
    return ListHelpers.filterByType(
      items: categories,
      type: type,
      getType: (category) => category.type,
    );
  }

  List<Widget> _buildCategorySection(
    BuildContext context,
    String title,
    List<CategoryData> categories,
  ) {
    return [
      _buildSectionHeaderSliver(title),
      _buildCategoryListSliver(context, categories),
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

  Widget _buildCategoryListSliver(
    BuildContext context,
    List<CategoryData> categories,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              _buildDismissibleCategoryItem(context, categories[index]),
          childCount: categories.length,
        ),
      ),
    );
  }

  Widget _buildDismissibleCategoryItem(
    BuildContext context,
    CategoryData category,
  ) {
    return Dismissible(
      key: Key(category.id),
      direction: DismissDirection.endToStart,
      background: _buildDismissBackground(),
      confirmDismiss: (direction) => _confirmDelete(context, category),
      child: CategoryItem(
        category: category,
        onTap: () => _showEditCategoryDialog(context, category),
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
      decoration: _buildDismissBackgroundDecoration(),
      child: _buildDeleteIcon(),
    );
  }

  BoxDecoration _buildDismissBackgroundDecoration() {
    return BoxDecoration(
      color: AppColors.error,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
    );
  }

  Widget _buildDeleteIcon() {
    return const Icon(
      Icons.delete_outline,
      color: Colors.white,
      size: AppDimensions.iconLarge,
    );
  }

  Future<bool?> _confirmDelete(BuildContext context, CategoryData category) {
    final l10n = AppLocalizations.of(context)!;
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: _buildDeleteDialogTitle(l10n),
        content: _buildDeleteDialogContent(l10n, category.name),
        actions: _buildDeleteDialogActions(dialogContext, context, category.id),
      ),
    );
  }

  Widget _buildDeleteDialogTitle(AppLocalizations l10n) {
    return Text(
      l10n.deleteCategory,
      style: const TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildDeleteDialogContent(AppLocalizations l10n, String categoryName) {
    return Text(
      l10n.confirmDeleteCategory(categoryName),
      style: const TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  List<Widget> _buildDeleteDialogActions(
    BuildContext dialogContext,
    BuildContext parentContext,
    String categoryId,
  ) {
    final l10n = AppLocalizations.of(parentContext)!;
    return [
      _buildCancelButton(dialogContext, l10n),
      _buildDeleteButton(dialogContext, parentContext, categoryId, l10n),
    ];
  }

  Widget _buildCancelButton(BuildContext dialogContext, AppLocalizations l10n) {
    return TextButton(
      onPressed: () => Navigator.pop(dialogContext, false),
      child: Text(l10n.cancel),
    );
  }

  Widget _buildDeleteButton(
    BuildContext dialogContext,
    BuildContext parentContext,
    String categoryId,
    AppLocalizations l10n,
  ) {
    return TextButton(
      onPressed: () {
        parentContext.read<CategoryCubit>().deleteCategory(categoryId);
        Navigator.pop(dialogContext, true);
      },
      child: Text(
        l10n.delete,
        style: const TextStyle(color: AppColors.expensesStart),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
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
}
