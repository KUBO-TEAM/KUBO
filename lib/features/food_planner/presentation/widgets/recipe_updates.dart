import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_updates/recipe_updates_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_info_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_updates_event_card.dart';

class RecipeUpdates extends StatefulWidget {
  const RecipeUpdates({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeUpdates> createState() => _RecipeUpdatesState();
}

class _RecipeUpdatesState extends State<RecipeUpdates> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RecipeUpdatesBloc>(context).add(
      RecipeUpdatesLatestRecipeFetched(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeUpdatesBloc, RecipeUpdatesState>(
      builder: (context, state) {
        if (state is RecipeUpdatesSuccess) {
          final latestRecipe = state.recipe;

          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                RecipeInfoPage.id,
                arguments: RecipeInfoPageArguments(
                  recipe: latestRecipe,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  RecipeUpdatesBody(
                    recipe: latestRecipe,
                  ),
                ],
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
