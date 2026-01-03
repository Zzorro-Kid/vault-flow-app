import 'package:test_app/core/data/sources/base_local_data_source.dart';
import 'package:test_app/core/services/storage_service.dart';
import 'package:test_app/features/category/data/models/category_data_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryDataModel>> getAllCategories();
  Future<void> addCategory(CategoryDataModel category);
  Future<void> updateCategory(CategoryDataModel category);
  Future<void> deleteCategory(String categoryId);
}

class CategoryLocalDataSourceImpl extends BaseLocalDataSource
    implements CategoryLocalDataSource {
  final StorageService storageService;

  CategoryLocalDataSourceImpl({required this.storageService});

  @override
  Future<List<CategoryDataModel>> getAllCategories() async {
    return executeStorageRead(
      () => storageService.loadCategories(),
      errorMessage: 'Failed to get categories',
    );
  }

  @override
  Future<void> addCategory(CategoryDataModel category) async {
    return executeStorageWrite(() async {
      final categories = await storageService.loadCategories();
      categories.add(category);
      await storageService.saveCategories(categories);
    }, errorMessage: 'Failed to add category');
  }

  @override
  Future<void> updateCategory(CategoryDataModel category) async {
    return executeStorageWrite(() async {
      final categories = await storageService.loadCategories();
      final index = categories.indexWhere((c) => c.id == category.id);

      if (index != -1) {
        categories[index] = category;
        await storageService.saveCategories(categories);
      }
    }, errorMessage: 'Failed to update category');
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    return executeStorageWrite(() async {
      final categories = await storageService.loadCategories();
      categories.removeWhere((c) => c.id == categoryId);
      await storageService.saveCategories(categories);
    }, errorMessage: 'Failed to delete category');
  }
}
