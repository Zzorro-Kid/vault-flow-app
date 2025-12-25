import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';
import 'package:test_app/features/category/domain/repositories/category_repository.dart';

class GetAllCategoriesUseCase {
  final CategoryRepository repository;

  GetAllCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryData>>> call() async {
    return await repository.getAllCategories();
  }
}
