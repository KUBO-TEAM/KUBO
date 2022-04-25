import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/features/food_planner/data/datasources/recipes_remote_data_source.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_repository.dart';

@LazySingleton(as: RecipeRepository)
class RecipeRepositoryImpl implements RecipeRepository {
  final RecipesRemoteDataSource recipesRemoteDataSource;

  RecipeRepositoryImpl(this.recipesRemoteDataSource);

  @override
  Future<Either<Failure, List<RecipeModel>>> fetchRecipes() async {
    try {
      final recipes = await recipesRemoteDataSource.fetchRecipes();

      return Right(recipes);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeModel>>> fetchFilteredRecipes(
      List<Ingredient> ingridients) async {
    try {
      final recipes =
          await recipesRemoteDataSource.fetchFilteredRecipes(ingridients);

      return Right(recipes);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
