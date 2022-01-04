import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';

class CreateMealPlanScreen extends StatelessWidget {
  static const String id = 'create_meal_plan_screen';

  CreateMealPlanScreen({Key? key}) : super(key: key);

  final List<Recipe> recommendedRecipes = [
    Recipe(
      name: 'Pinakbet',
      description: '',
      imageUrl:
          'https://www.foxyfolksy.com/wp-content/uploads/2016/09/pinakbet-640.jpg',
    ),
    Recipe(
      name: 'Sinigang na Baboy Ribs',
      description: '',
      imageUrl:
          'https://panlasangpinoy.com/wp-content/uploads/2021/12/Porknigang-Recipe.jpg',
    ),
    Recipe(
      name: 'Pinakbet',
      description: '',
      imageUrl:
          'https://www.foxyfolksy.com/wp-content/uploads/2016/09/pinakbet-640.jpg',
    ),
  ];

  final List<Recipe> popularRecipes = [
    Recipe(
      name: 'Pinakbet',
      description: '',
      imageUrl:
          'https://www.foxyfolksy.com/wp-content/uploads/2016/09/pinakbet-640.jpg',
    ),
    Recipe(
      name: 'Sinigang na Baboy Ribs',
      description: '',
      imageUrl:
          'https://panlasangpinoy.com/wp-content/uploads/2021/12/Porknigang-Recipe.jpg',
    ),
    Recipe(
      name: 'Pinakbet',
      description: '',
      imageUrl:
          'https://www.foxyfolksy.com/wp-content/uploads/2016/09/pinakbet-640.jpg',
    ),
    Recipe(
      name: 'Pinakbet',
      description: '',
      imageUrl:
          'https://www.foxyfolksy.com/wp-content/uploads/2016/09/pinakbet-640.jpg',
    ),
    Recipe(
      name: 'Pinakbet',
      description: '',
      imageUrl:
          'https://www.foxyfolksy.com/wp-content/uploads/2016/09/pinakbet-640.jpg',
    ),
    Recipe(
      name: 'Pinakbet',
      description: '',
      imageUrl:
          'https://www.foxyfolksy.com/wp-content/uploads/2016/09/pinakbet-640.jpg',
    ),
    Recipe(
      name: 'Pinakbet',
      description: '',
      imageUrl:
          'https://www.foxyfolksy.com/wp-content/uploads/2016/09/pinakbet-640.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: kBlackPrimary, //change your color here
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recommended Recipes',
                  style: kSubTitleTextStyle,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 190,
                  child: ListView.builder(
                    itemCount: recommendedRecipes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return RecommendedCard(
                        recipe: recommendedRecipes[index],
                      );
                    },
                  ),
                ),
                const Text(
                  'Popular Recipes',
                  style: kSubTitleTextStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: List.generate(
                    popularRecipes.length,
                    (index) => PopularCard(
                      recipe: popularRecipes[index],
                    ),
                  ),
                ),
              ],
            ),
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
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
              'https://www.foxyfolksy.com/wp-content/uploads/2016/09/pinakbet-640.jpg',
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
                  "Pakbet",
                  style: kSubTitleTextStyle.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...",
                  style: kCaptionTextStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RecommendedCard extends StatelessWidget {
  const RecommendedCard({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              style: kCaptionTextStyle.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
