import 'package:test_app/core/data/sources/base_local_data_source.dart';
import 'package:test_app/core/secure_prefs.dart';
import 'package:test_app/features/category/data/models/category_data_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryDataModel>> getAllCategories();
  Future<void> addCategory(CategoryDataModel category);
  Future<void> updateCategory(CategoryDataModel category);
  Future<void> deleteCategory(String categoryId);
}

class CategoryLocalDataSourceImpl extends BaseLocalDataSource
    implements CategoryLocalDataSource {
  @override
  final SecurePrefs securePrefs;

  CategoryLocalDataSourceImpl({required this.securePrefs});

  @override
  Future<List<CategoryDataModel>> getAllCategories() async {
    return executeStorageRead(() async {
      return await super.loadCategoriesFromStorage();
    }, errorMessage: 'Failed to get categories');
  }

  @override
  Future<void> addCategory(CategoryDataModel category) async {
    return executeStorageWrite(() async {
      final categories = await super.loadCategoriesFromStorage();
      categories.add(category);
      await saveCategories(categories);
    }, errorMessage: 'Failed to add category');
  }

  @override
  Future<void> updateCategory(CategoryDataModel category) async {
    return executeStorageWrite(() async {
      final categories = await super.loadCategoriesFromStorage();
      final index = categories.indexWhere((c) => c.id == category.id);

      if (index != -1) {
        categories[index] = category;
        await saveCategories(categories);
      }
    }, errorMessage: 'Failed to update category');
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    return executeStorageWrite(() async {
      final categories = await super.loadCategoriesFromStorage();
      categories.removeWhere((c) => c.id == categoryId);
      await saveCategories(categories);
    }, errorMessage: 'Failed to delete category');
  }
}
