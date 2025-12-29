import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/core/utils/ui_helpers.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/category/presentation/cubit/category_cubit.dart';
import 'package:test_app/features/category/presentation/cubit/category_state.dart';
import 'package:test_app/features/category/presentation/widgets/add_category_dialog.dart';
import 'package:test_app/features/category/presentation/widgets/category_app_bar.dart';
import 'package:test_app/features/category/presentation/widgets/category_error_view.dart';
import 'package:test_app/features/category/presentation/widgets/category_loaded_view.dart';
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
          appBar: const CategoryAppBar(),
          body: _buildBody(),
          floatingActionButton: _buildFAB(context),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return switch (state) {
          CategoryLoading() => const LoadingIndicator(),
          CategoryLoaded() => CategoryLoadedView(categories: state.categories),
          CategoryError() => CategoryErrorView(
              message: state.message,
              onRetry: () => context.read<CategoryCubit>().loadCategories(),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  void _showOperationSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: UiHelpers.getOperationSnackBarColor(message),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddCategoryDialog(context),
      backgroundColor: AppColors.primary,
      child: const Icon(Icons.add, color: Colors.white),
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
