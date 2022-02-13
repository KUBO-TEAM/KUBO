import 'package:kubo/features/food_planner/domain/entities/ingredients_box.dart';

class IngredientsBoxModel extends IngredientsBox {
  const IngredientsBoxModel({
    required String id,
    required List<String> ingredients,
    required bool isExpanded,
  }) : super(
          id: id,
          ingredients: ingredients,
          isExpanded: isExpanded,
        );
}
