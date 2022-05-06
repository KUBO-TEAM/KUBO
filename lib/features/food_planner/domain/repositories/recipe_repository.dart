import 'package:dartz/dartz.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/features/food_planner/domain/entities/category.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_cache_recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> fetchRecipes();
  Future<Either<Failure, List<Recipe>>> fetchFilteredRecipes(
    List<Category> category,
  );

  Future<Either<Failure, Recipe>> fetchRecipe(String recipeId);

  Future<Either<Failure, String>> createCacheRecipe(
    CreateCacheRecipeParams recipes,
  );

  Future<Either<Failure, List<Recipe>>> fetchCachedRecipes();
}
