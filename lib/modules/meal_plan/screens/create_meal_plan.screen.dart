import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:kubo/modules/meal_plan/screens/assign_meal_time.screen.dart';

class CreateMealPlanScreen extends StatelessWidget {
  static const String id = 'create_meal_plan_screen';

  CreateMealPlanScreen({Key? key}) : super(key: key);

  final List<Recipe> recommendedRecipes = [
    Recipe(
      name: 'Pinakbet Tagalog',
      description:
          'Pinakbet Tagalog is a Filipino vegetable dish. It is composed of a variety of vegetables and it also has a protein component.',
      imageUrl:
          'https://www.foxyfolksy.com/wp-content/uploads/2016/09/pinakbet-640.jpg',
    ),
    Recipe(
      name: 'Sinigang na Baboy Ribs',
      description:
          'One of the most beloved and familiar Filipino dishes out there, sinigang introduces a great balance of warmth and sourness.',
      imageUrl:
          'https://panlasangpinoy.com/wp-content/uploads/2021/12/Porknigang-Recipe.jpg',
    ),
    Recipe(
      name: 'Ginisang Ampalaya',
      description:
          'We make it with a couple of kitchen basics. This includes garlic, black pepper, eggs and tomatoes.',
      imageUrl:
          'https://panlasangpinoy.com/wp-content/uploads/2009/07/Ginisang-Ampalaya-with-Eggs.jpg',
    ),
  ];

  final List<Recipe> popularRecipes = [
    Recipe(
      name: 'Vegetable Okoy',
      description:
          'Okoy is one of the best snacks or appetizers out there. Its stunning, golden brown appearance is one hard to ignore',
      imageUrl:
          'https://panlasangpinoy.com/wp-content/uploads/2021/12/Crispy-Vegetable-Okoy-Recipe.jpg',
    ),
    Recipe(
      name: 'Ginisang Sigarilyas Recipe',
      description:
          'Ginisang Sigarilyas is a classic dish with onion, garlic, and of course, the refreshing taste of crunchy sigarilyas or winged bean, this is a recipe that satisfies everything you’d want in your delicious Filipino ulam. ',
      imageUrl:
          'https://panlasangpinoy.com/wp-content/uploads/2021/12/Porknigang-Recipe.jpg',
    ),
    Recipe(
      name: 'Chopsuey with Chicken and Broccoli',
      description:
          'The Philippines is home to an abundance of fresh vegetables that come alive in an array of dishes within our cuisine. ',
      imageUrl:
          'https://panlasangpinoy.com/wp-content/uploads/2021/08/How-to-Cook-Chopsuey-683x1024.jpg',
    ),
    Recipe(
      name: 'Laswa Recipe',
      description:
          'These days, it might get pretty difficult to get ahold of healthy food from outside. ',
      imageUrl:
          'https://panlasangpinoy.com/wp-content/uploads/2021/08/Laswa-Recipe-683x1024.jpg',
    ),
    Recipe(
      name: 'Binagoongan Bagnet with Talong',
      description:
          'Binagoongan bagnet with talong be considered as a Crispy Binagoongan version. This dish is simply delicious. ',
      imageUrl:
          'https://panlasangpinoy.com/wp-content/uploads/2021/07/Binagoongan-Bagnet-with-Talong-Recipe.jpg',
    ),
    Recipe(
      name: 'Ginisang Munggo',
      description:
          'Some dishes in a certain cuisine are known to best describe the feeling of home-cooked meals from that particular country.',
      imageUrl:
          'https://panlasangpinoy.com/wp-content/uploads/2021/07/Ginisang-Munggo-704x1024.jpg',
    ),
    Recipe(
      name: 'Easy Utan Bisaya',
      description:
          'Have you ever heard of Utan Bisaya before? For locals of the Visayas or those with Visayan origins, Easy Utan Bisaya (or Law-Uy) ',
      imageUrl:
          'https://panlasangpinoy.com/wp-content/uploads/2021/06/easy-utan-bisaya.jpg',
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
                      onPressed: () {
                        Navigator.pushNamed(context, AssignMealTimeScreen.id);
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
                    onPressed: () {
                      Navigator.pushNamed(context, AssignMealTimeScreen.id);
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
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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
