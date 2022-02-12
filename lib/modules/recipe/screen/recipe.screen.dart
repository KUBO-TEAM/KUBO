import 'package:flutter/material.dart';
import 'package:kubo/constants/colors_constants.dart';
import 'package:kubo/constants/text_styles_constants.dart';
import 'package:kubo/modules/meal_plan/recipes.examples.dart';
import 'package:kubo/modules/recipe/screen/recipeSteps.screen.dart';
import 'package:kubo/widgets/text_fields/search.field.dart';

class RecipeScreen extends StatefulWidget {
  static const String id = 'recipe_screen';

  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
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
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, RecipeSteps.id,arguments: popularRecipes[index]),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
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
