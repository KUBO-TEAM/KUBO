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
      height: 260,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Monday, 11:00 PM - 12:00 PM',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RecipeInfoIconWithText(
                icon: Icons.outdoor_grill,
                title: 'Cook Time',
                data: recipe.cookTime.toString(),
                color: Colors.white,
              ),
              RecipeInfoIconWithText(
                icon: Icons.hourglass_top,
                title: 'Prep Time',
                data: recipe.prepTime.toString(),
                color: Colors.white,
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
                color: Colors.white,
              ),
              RecipeInfoIconWithText(
                icon: Icons.brunch_dining,
                data: recipe.cuisine,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
