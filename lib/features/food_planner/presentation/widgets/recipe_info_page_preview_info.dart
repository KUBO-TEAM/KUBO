import 'package:flutter/material.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_info_icon_with_text.dart';

class RecipeInfoPagePreviewInfo extends StatelessWidget {
  const RecipeInfoPagePreviewInfo({Key? key, required this.recipe})
      : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RecipeInfoIconWithText(
                icon: Icons.outdoor_grill,
                title: 'Cook Time',
                data: recipe.cookTime.toString(),
              ),
              RecipeInfoIconWithText(
                icon: Icons.hourglass_top,
                title: 'Prep Time',
                data: recipe.prepTime.toString(),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RecipeInfoIconWithText(
                icon: Icons.restaurant,
                data: recipe.course,
              ),
              RecipeInfoIconWithText(
                icon: Icons.brunch_dining,
                data: recipe.cuisine,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const RecipeInfoIconWithText(
            icon: Icons.group,
            title: 'Servings',
            data: '12',
          ),
        ],
      ),
    );
  }
}
