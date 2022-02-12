import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/features/food_planner/presentation/pages/create_meal_plan_page.dart';
import 'package:kubo/modules/meal_plan/models/ingredients.dart';

class SelectIngredientBody extends StatelessWidget {
  const SelectIngredientBody({
    Key? key,
    required this.ingredient,
  }) : super(key: key);

  final Ingredients ingredient;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: List.generate(
            ingredient.ingredients.length,
            (int index) {
              return ListTile(
                leading: const Icon(
                  Icons.grade,
                  color: kGreenPrimary,
                ),
                title: Text(
                  ingredient.ingredients[index],
                  style: kPreSubTitleTextStyle.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(
          thickness: 1,
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 16.0,
              left: 8.0,
              right: 8.0,
            ),
            child: Center(
              child: Text(
                'CREATE MEAL PLAN',
                style: kCaptionTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, CreateMealPlanPage.id);
          },
        ),
      ],
    );
  }
}
