import 'package:dartz/dartz.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeModel>>> fetchRecipes();
  Future<Either<Failure, List<RecipeModel>>> fetchFilteredRecipes(
      List<Ingredient> ingredients);
}
