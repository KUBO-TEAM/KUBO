import 'package:kubo/features/food_planner/domain/entities/ingredients_box.dart';

// ignore: must_be_immutable
class IngredientsBoxModel extends IngredientsBox {
  IngredientsBoxModel({
    required String id,
    required List<String> ingredients,
    required bool isExpanded,
  }) : super(
          id: id,
          ingredients: ingredients,
          isExpanded: isExpanded,
        );
}
