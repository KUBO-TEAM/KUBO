import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/reminder_bell.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_info_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_list_tile.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_list_tile_parallax.dart';
import 'package:kubo/features/food_planner/presentation/widgets/search_field.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/smart_recipe_list/smart_recipe_list_bloc.dart';

class RecipesPageArguments {
  final List<Category>? categories;
  final int? recipeScheduleArrayIndex;

  RecipesPageArguments({
    this.categories,
    this.recipeScheduleArrayIndex,
  });
}

class RecipesPage extends StatefulWidget {
  static const String id = 'recipe_page';

  const RecipesPage({Key? key, required this.arguments}) : super(key: key);

  final RecipesPageArguments arguments;

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  @override
  void initState() {
    super.initState();

    if (widget.arguments.categories != null) {
      BlocProvider.of<RecipeBloc>(context).add(
        RecipeModelListFilter(
          categories: widget.arguments.categories,
        ),
      );
    } else {
      BlocProvider.of<RecipeBloc>(context).add(
        RecipeModelListFetched(),
      );
    }
  }

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
            fontFamily: 'Montserrat Bold',
            fontSize: 24.0,
          ),
        ),
        actions: const [
          ReminderBell(
            color: Colors.black,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SearchField(
                onChanged: (String query) =>
                    BlocProvider.of<RecipeBloc>(context).add(
                  RecipeModelListFilter(query: query),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: BlocBuilder<RecipeBloc, RecipeState>(
                builder: (context, state) {
                  if (state is RecipeInProgress) {
                    return GridView.builder(
                      itemCount: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return const RecipeListTileSkeleton();
                      },
                    );
                  } else if (state is RecipeSuccess) {
                    final recipes = state.recipes;

                    return GridView.builder(
                      itemCount: recipes.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return RecipeListItemParallax(
                          recipe: recipes[index],
                          onPressed: (recipe) {
                            final recipeScheduleArrayIndex =
                                widget.arguments.recipeScheduleArrayIndex;
                            if (recipeScheduleArrayIndex != null) {
                              BlocProvider.of<SmartRecipeListBloc>(context).add(
                                SmartRecipeListRecipeScheduleRecipeEdited(
                                  recipeScheduleArrayIndex:
                                      recipeScheduleArrayIndex,
                                  recipe: recipe,
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              Navigator.pushNamed(
                                context,
                                RecipeInfoPage.id,
                                arguments: RecipeInfoPageArguments(
                                  recipe: recipe,
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
