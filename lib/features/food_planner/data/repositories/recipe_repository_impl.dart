import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/features/food_planner/data/datasources/recipe_local_data_source.dart';
import 'package:kubo/features/food_planner/data/datasources/recipes_remote_data_source.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/repositories/recipe_repository.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_cache_recipe.dart';

@LazySingleton(as: RecipeRepository)
class RecipeRepositoryImpl implements RecipeRepository {
  final RecipesRemoteDataSource recipesRemoteDataSource;
  final RecipeLocalDataSource recipeLocalDataSource;

  RecipeRepositoryImpl(
      this.recipesRemoteDataSource, this.recipeLocalDataSource);

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
      List<Category> categories) async {
    try {
      final recipes =
          await recipesRemoteDataSource.fetchFilteredRecipes(categories);

      return Right(recipes);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Recipe>> fetchRecipe(String recipeId) async {
    try {
      final recipes = await recipesRemoteDataSource.fetchRecipe(recipeId);

      return Right(recipes);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CreateCacheRecipeResponse>> createCacheRecipe(
    CreateCacheRecipeParams params,
  ) async {
    try {
      final response = await recipeLocalDataSource.createCacheRecipe(params);

      return Right(response);
    } on ServerException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> fetchCachedRecipes() async {
    try {
      final recipes = await recipeLocalDataSource.fetchCachedRecipes();

      return Right(recipes);
    } on ServerException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Recipe>> fetchLatestRecipe() async {
    try {
      final recipe = await recipesRemoteDataSource.fetchLatestRecipe();

      return Right(recipe);
    } on ServerException {
      return Left(CacheFailure());
    }
  }
}
