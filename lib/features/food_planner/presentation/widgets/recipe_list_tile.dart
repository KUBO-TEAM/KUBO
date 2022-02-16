import 'package:flutter/material.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/core/examples/recipes.examples.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_steps_page.dart';

class RecipeListTile extends StatelessWidget {
  const RecipeListTile(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RecipeStepsPage.id,
        arguments: popularRecipes[index],
      ),
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Row(
            children: [
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Hero(
                  tag: "recipe-img-${popularRecipes[index].imageUrl}",
                  child: Image.network(
                    popularRecipes[index].imageUrl,
                    fit: BoxFit.cover,
                    height: 112.0,
                    width: 112.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      popularRecipes[index].name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: kSubTitleTextStyle.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      popularRecipes[index].description,
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
      ),
    );
  }
}
