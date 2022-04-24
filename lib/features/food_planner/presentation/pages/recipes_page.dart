import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_list_tile.dart';
import 'package:kubo/features/food_planner/presentation/widgets/search_field.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe/recipe_bloc.dart';

class RecipesPage extends StatefulWidget {
  static const String id = 'recipe_page';

  const RecipesPage({Key? key}) : super(key: key);

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<RecipeBloc>(context).add(
      RecipeModelListFetched(),
    );
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
            fontFamily: 'Pushster',
            fontSize: 30.0,
          ),
        ),
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
                        return RecipeListTile(
                          recipe: recipes[index],
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
