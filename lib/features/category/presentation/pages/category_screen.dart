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
import 'package:test_app/features/category/presentation/widgets/category_error_view.dart';
import 'package:test_app/features/category/presentation/widgets/category_item.dart';
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.incomeStart,
                ),
              );
            default:
              break;
          }
        },
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
          bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 2),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: AppDimensions.appBarHeightOther,
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
          (context, index) => CategoryItem(
            category: categories[index],
            onDelete: () => _showDeleteConfirmation(context, categories[index]),
          ),
          childCount: categories.length,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, CategoryData category) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Category'),
        content: Text('Are you sure you want to delete "${category.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CategoryCubit>().deleteCategory(category.id);
              Navigator.pop(dialogContext);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.expensesStart),
            ),
          ),
        ],
      ),
    );
  }
}
