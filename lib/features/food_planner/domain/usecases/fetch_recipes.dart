import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_repository.dart';

@lazySingleton
class FetchRecipes implements UseCase<List<Recipe>, NoParams> {
  final RecipeRepository repository;

  FetchRecipes(this.repository);

  @override
  Future<Either<Failure, List<Recipe>>> call(NoParams params) async {
    return await repository.fetchRecipes();
  }
}
