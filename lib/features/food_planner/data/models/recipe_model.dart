import 'package:kubo/features/food_planner/data/models/ingredient_model.dart';
import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  const RecipeModel({
    required String id,
    required String name,
    required String description,
    required String course,
    required String cuisine,
    required int prepTime,
    required int cookTime,
    required int servings,
    required String reference,
    required String displayPhoto,
    required List<String> categories,
    required List<Ingredient> ingredients,
    required List<String> instructions,
    required String createdAt,
  }) : super(
          id: id,
          name: name,
          description: description,
          course: course,
          cuisine: cuisine,
          prepTime: prepTime,
          cookTime: cookTime,
          servings: servings,
          reference: reference,
          displayPhoto: displayPhoto,
          categories: categories,
          ingredients: ingredients,
          instructions: instructions,
          createdAt: createdAt,
        );

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      course: json['course'],
      cuisine: json['cuisine'],
      prepTime: (json['prep_time'] as num).toInt(),
      cookTime: (json['cook_time'] as num).toInt(),
      servings: (json['servings'] as num).toInt(),
      reference: json['reference'],
      displayPhoto: json['displayPhoto'],
      categories: List<String>.from(json['categories']),
      ingredients: List<Ingredient>.from((json['ingredients'] as List).map(
        (model) => IngredientModel.fromJson(model),
      )),
      instructions: List<String>.from(json['instructions']),
      createdAt: json['createdAt'],
    );
  }
}
