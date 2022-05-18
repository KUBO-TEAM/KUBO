import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:kubo/features/food_planner/domain/usecases/create_cache_recipe.dart';

abstract class RecipeLocalDataSource {
  /// create [RecipeModel] to the cached.
  ///
  /// Throws [CacheException] if data is not save.
  ///
  Future<CreateCacheRecipeResponse> createCacheRecipe(
    CreateCacheRecipeParams params,
  );

  Future<List<Recipe>> fetchCachedRecipes();
}

@LazySingleton(as: RecipeLocalDataSource)
class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final Box<Recipe> recipeBox;

  RecipeLocalDataSourceImpl({required this.recipeBox});

  @override
  Future<CreateCacheRecipeResponse> createCacheRecipe(
      CreateCacheRecipeParams params) async {
    for (Recipe recipeModel in params.recipes) {
      recipeBox.put(recipeModel.id, recipeModel);
    }

    return const CreateCacheRecipeResponse(
      message: 'Successfully Cache Recipes!',
    );
  }

  @override
  Future<List<Recipe>> fetchCachedRecipes() async {
    return recipeBox.values.toList().reversed.toList();
  }
}
