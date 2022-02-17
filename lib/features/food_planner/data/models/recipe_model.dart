import 'package:kubo/features/food_planner/domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  const RecipeModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
        );
}
