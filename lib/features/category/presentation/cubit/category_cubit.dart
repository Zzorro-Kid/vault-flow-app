import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';
import 'package:test_app/features/category/domain/usecases/add_category_usecase.dart';
import 'package:test_app/features/category/domain/usecases/delete_category_usecase.dart';
import 'package:test_app/features/category/domain/usecases/get_all_categories_usecase.dart';
import 'package:test_app/features/category/domain/usecases/update_category_usecase.dart';
import 'package:test_app/features/category/presentation/cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  CategoryCubit({
    required this.getAllCategoriesUseCase,
    required this.addCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(const CategoryInitial());

  Future<void> loadCategories() async {
    emit(const CategoryLoading());

    final result = await getAllCategoriesUseCase();

    result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (categories) => emit(CategoryLoaded(categories)),
    );
  }

  Future<void> addCategory(CategoryData category) async {
    final result = await addCategoryUseCase(category);

    result.fold((failure) => emit(CategoryError(failure.message)), (_) {
      emit(const CategoryOperationSuccess('Category added successfully'));
      loadCategories();
    });
  }

  Future<void> updateCategory(CategoryData category) async {
    final result = await updateCategoryUseCase(category);

    result.fold((failure) => emit(CategoryError(failure.message)), (_) {
      emit(const CategoryOperationSuccess('Category updated successfully'));
      loadCategories();
    });
  }

  Future<void> deleteCategory(String categoryId) async {
    final result = await deleteCategoryUseCase(categoryId);

    result.fold((failure) => emit(CategoryError(failure.message)), (_) {
      emit(const CategoryOperationSuccess('Category deleted successfully'));
      loadCategories();
    });
  }
}
