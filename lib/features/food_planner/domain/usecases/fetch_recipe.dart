import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_repository.dart';

@lazySingleton
class FetchRecipe implements UseCase<Recipe, String> {
  final RecipeRepository repository;

  FetchRecipe(this.repository);

  @override
  Future<Either<Failure, Recipe>> call(String recipeId) async {
    return await repository.fetchRecipe(recipeId);
  }
}
