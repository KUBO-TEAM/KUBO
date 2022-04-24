import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';

class IngredientModel extends Ingredient {
  const IngredientModel({
    required String name,
    required int quantity,
    required DateTime dateCreated,
  }) : super(
          name: name,
          quantity: quantity,
          dateCreated: dateCreated,
        );
}
