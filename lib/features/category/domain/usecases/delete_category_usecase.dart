import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/category/domain/repositories/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase(this.repository);

  Future<Either<Failure, void>> call(String categoryId) async {
    return await repository.deleteCategory(categoryId);
  }
}
