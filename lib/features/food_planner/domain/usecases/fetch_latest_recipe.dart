import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_repository.dart';

@lazySingleton
class FetchLatestRecipe implements UseCase<Recipe, NoParams> {
  final RecipeRepository repository;

  FetchLatestRecipe(this.repository);

  @override
  Future<Either<Failure, Recipe>> call(NoParams recipeId) async {
    return await repository.fetchLatestRecipe();
  }
}
