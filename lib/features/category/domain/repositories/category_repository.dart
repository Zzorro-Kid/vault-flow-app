import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryData>>> getAllCategories();
  Future<Either<Failure, void>> addCategory(CategoryData category);
  Future<Either<Failure, void>> updateCategory(CategoryData category);
  Future<Either<Failure, void>> deleteCategory(String categoryId);
}
