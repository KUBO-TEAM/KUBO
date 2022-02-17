import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/examples/recipes.examples.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_list_tile.dart';
import 'package:kubo/features/food_planner/presentation/widgets/search_field.dart';

class RecipePage extends StatelessWidget {
  static const String id = 'recipe_page';

  const RecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kBlackPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: const Text(
          'Recipe List',
          style: TextStyle(
            color: kBlackPrimary,
            fontFamily: 'Pushster',
            fontSize: 30.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SearchField(),
            const SizedBox(
              height: 12.0,
            ),
            Expanded(
              child: Container(
                color: kBackgroundGrey,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                  itemCount: popularRecipes.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 13.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return RecipeListTile(index);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
