import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe/recipe_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/home_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/smart_recipe_list_tile.dart';

class SmartRecipeListPage extends StatefulWidget {
  static const String id = 'smart_recipe_list_page';

  const SmartRecipeListPage({Key? key}) : super(key: key);

  @override
  State<SmartRecipeListPage> createState() => _SmartRecipeListPageState();
}

class _SmartRecipeListPageState extends State<SmartRecipeListPage> {
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
      backgroundColor: Colors.white,
      appBar: KuboAppBar(
        'Smart Recipe List',
        onBackButtonPressed: () => Navigator.of(context).pop(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                  icon: const Icon(
                    Icons.event,
                    color: Colors.white,
                  ),
                  title: const Text('Check timetable'),
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 8.0,
                ),
                RoundedButton(
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  title: const Text('Save schedule'),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      HomePage.id,
                      (route) => route.isFirst,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: BlocBuilder<RecipeBloc, RecipeState>(
              builder: (context, state) {
                if (state is RecipeSuccess) {
                  final recipes = state.recipes;

                  return ListView.builder(
                    itemCount: recipes.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return SmartRecipeListTile(
                        recipe: recipes[index],
                      );
                    },
                  );
                }

                return ListView.builder(
                  itemCount: 10,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return const SmartRecipeListSkeleton();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
