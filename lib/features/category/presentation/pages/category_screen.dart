import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/utils/ui_helpers.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/category/presentation/cubit/category_cubit.dart';
import 'package:test_app/features/category/presentation/cubit/category_state.dart';
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
}
