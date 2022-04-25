import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:kubo/core/constants/string_constants.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/features/food_planner/data/models/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';

abstract class RecipesRemoteDataSource {
  /// fetch [RecipeModel] in remote
  ///
  /// Throws [ServerException] if no remote data is present.
  ///
  Future<List<RecipeModel>> fetchRecipes();
  Future<List<RecipeModel>> fetchFilteredRecipes(List<Ingredient> ingredients);
}

@module
abstract class RemoteModule {
  http.Client get prefs => http.Client();
}

@LazySingleton(as: RecipesRemoteDataSource)
class RecipesRemoteDataSourceImpl implements RecipesRemoteDataSource {
  final http.Client client;

  RecipesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RecipeModel>> fetchRecipes() async {
    final response = await client.get(
      Uri.parse('$kKuboUrl/api/recipes'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      var data = body['data'];

      List<RecipeModel> recipes = [];

      for (var value in data) {
        recipes.add(RecipeModel.fromJson(value));
      }

      return recipes;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecipeModel>> fetchFilteredRecipes(
    List<Ingredient> ingredients,
  ) async {
    List<String> categories = [];

    for (var value in ingredients) {
      categories.add(value.name);
    }

    final response = await client.post(
      Uri.parse('$kKuboUrl/api/recipes/filter'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {"categories": categories},
      ),
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      var data = body['data'];

      List<RecipeModel> recipes = [];

      for (var value in data) {
        recipes.add(RecipeModel.fromJson(value));
      }

      return recipes;
    } else {
      throw ServerException();
    }
  }
}
