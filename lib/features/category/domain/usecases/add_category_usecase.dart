import 'package:dartz/dartz.dart';
import 'package:test_app/core/errors/failures.dart';
import 'package:test_app/features/category/domain/entities/category_data.dart';
import 'package:test_app/features/category/domain/repositories/category_repository.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  Future<Either<Failure, void>> call(CategoryData category) async {
    return await repository.addCategory(category);
  }
}
