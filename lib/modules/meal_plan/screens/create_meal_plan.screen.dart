import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/sizes.constants.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:kubo/modules/meal_plan/screens/assign_meal_time.screen.dart';
import 'package:kubo/modules/meal_plan/recipes.examples.dart';

class CreateMealPlanScreen extends StatelessWidget {
  static const String id = 'create_meal_plan_screen';

  const CreateMealPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: kAppBarPrefferedSize,
        child: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: kBlackPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: const Text(
            'Create Meal Plan',
            style: TextStyle(
              color: kBlackPrimary,
              fontFamily: 'Pushster',
              fontSize: 30.0,
            ),
          ),
        ),
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
              SizedBox(
                height: 190,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: recommendedRecipes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return RecommendedCard(
                      onPressed: (Recipe recipe) {
                        Navigator.pushNamed(
                          context,
                          AssignMealTimeScreen.id,
                          arguments: AssignMealTimeScreenArguments(
                            recipe: recipe,
                          ),
                        );
                      },
                      recipe: recommendedRecipes[index],
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Popular Recipes',
                  style: kSubTitleTextStyle.copyWith(
                    color: kBrownPrimary,
                  ),
                ),
              ),
              Column(
                children: List.generate(
                  popularRecipes.length,
                  (index) => PopularCard(
                    onPressed: (Recipe recipe) {
                      Navigator.pushNamed(
                        context,
                        AssignMealTimeScreen.id,
                        arguments: AssignMealTimeScreenArguments(
                          recipe: recipe,
                        ),
                      );
                    },
                    recipe: popularRecipes[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularCard extends StatelessWidget {
  const PopularCard({
    Key? key,
    required this.recipe,
    required this.onPressed,
  }) : super(key: key);

  final Recipe recipe;
  final Function(Recipe) onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(recipe);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(13.0)),
              ),
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
                height: 80.0,
                width: 75.0,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: kSubTitleTextStyle.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    recipe.description,
                    style: kCaptionTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecommendedCard extends StatelessWidget {
  const RecommendedCard({
    Key? key,
    required this.recipe,
    required this.onPressed,
  }) : super(key: key);

  final Recipe recipe;
  final Function(Recipe) onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(recipe);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(13.0)),
              ),
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
                height: 150.0,
                width: 180.0,
              ),
            ),
            SizedBox(
              width: 180.0,
              child: Text(
                recipe.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: kCaptionTextStyle.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
