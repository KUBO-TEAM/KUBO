import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';

class CreateMealPlanPage extends StatelessWidget {
  static const String id = 'create_meal_plan_page';

  const CreateMealPlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KuboAppBar(
        'Create Meal Plan',
        onBackButtonPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Recommended Recipes',
                  style: kSubTitleTextStyle.copyWith(
                    color: kBrownPrimary,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 190,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //     itemCount: recommendedRecipes.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return RecommendedCard(
              //         onPressed: (Recipe recipe) =>
              //             _navigateToAssignMealTimePage(recipe, context),
              //         recipe: recommendedRecipes[index],
              //       );
              //     },
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Popular Recipes',
                  style: kSubTitleTextStyle.copyWith(
                    color: kBrownPrimary,
                  ),
                ),
              ),
              // Column(
              //   children: List.generate(
              //     popularRecipes.length,
              //     (index) => PopularCard(
              //       onPressed: (Recipe recipe) =>
              //           _navigateToAssignMealTimePage(recipe, context),
              //       recipe: popularRecipes[index],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
