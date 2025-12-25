import 'package:dartz/dartz.dart';
import 'package:test_app/core/data/repositories/base_repository.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/category/data/models/category_data_model.dart';
import 'package:test_app/features/category/data/sources/category_local_data_source.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';
import 'package:test_app/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends BaseRepository
    implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CategoryData>>> getAllCategories() async {
    return executeRepositoryCall(() async {
      final categories = await localDataSource.getAllCategories();
      return categories;
    });
  }

  @override
  Future<Either<Failure, void>> addCategory(CategoryData category) async {
    return executeRepositoryCall(() async {
      await localDataSource.addCategory(CategoryDataModel.fromEntity(category));
    });
  }

  @override
  Future<Either<Failure, void>> updateCategory(CategoryData category) async {
    return executeRepositoryCall(() async {
      await localDataSource.updateCategory(
        CategoryDataModel.fromEntity(category),
      );
    });
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String categoryId) async {
    return executeRepositoryCall(() async {
      await localDataSource.deleteCategory(categoryId);
    });
  }
}
