import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';

class IngredientModel extends Ingredient {
  const IngredientModel({
    required String name,
    required double quantity,
  }) : super(
          name: name,
          quantity: quantity,
        );

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['ingredient'],
      quantity: (json['quantity'] as num).toDouble(),
    );
  }
}
