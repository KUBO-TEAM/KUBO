import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart';

@lazySingleton
class FetchCategories implements UseCase<List<Category>, NoParams> {
  final SmartRecipeSelectionRepository repository;

  FetchCategories(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(
    NoParams params,
  ) async {
    return await repository.fetchCategories();
  }
}
