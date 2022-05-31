import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/pages/generated_menu_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/home_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/smart_recipe_list/smart_recipe_list_bloc.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/smart_recipe_list_tile.dart';

class SmartRecipeListPageArguments {
  final List<Category> categories;

  SmartRecipeListPageArguments({required this.categories});
}

class SmartRecipeListPage extends StatefulWidget {
  static const String id = 'smart_recipe_list_page';

  const SmartRecipeListPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final SmartRecipeListPageArguments arguments;

  @override
  State<SmartRecipeListPage> createState() => _SmartRecipeListPageState();
}

class _SmartRecipeListPageState extends State<SmartRecipeListPage> {
  List<RecipeSchedule> recipeSchedules = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SmartRecipeListBloc>(context).add(
      SmartRecipeListRecipeSchedulesGenerated(
        categories: widget.arguments.categories,
      ),
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
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      GeneratedMenuPage.id,
                      arguments: GeneratedMenuPageArguments(
                        recipeSchedules: recipeSchedules,
                      ),
                    );
                  },
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
                  onPressed: () async {
                    BlocProvider.of<SmartRecipeListBloc>(context).add(
                      SmartRecipeListRecipeSchedulesSaved(
                        recipeSchedules: recipeSchedules,
                      ),
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
            child: BlocConsumer<SmartRecipeListBloc, SmartRecipeListState>(
              listener: (context, state) async {
                if (state is SmartRecipeListCreateSuccess) {
                  await ArtSweetAlert.show(
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.success,
                      title: "Successfully save schedules!",
                      confirmButtonColor: kGreenPrimary,
                    ),
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    HomePage.id,
                    (route) => route.isFirst,
                  );
                }
              },
              builder: (context, state) {
                if (state is SmartRecipeListFetchSuccess) {
                  recipeSchedules = state.recipeSchedules;

                  return ListView.builder(
                    itemCount: state.recipeSchedules.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return SmartRecipeListTile(
                        recipeSchedule: recipeSchedules[index],
                        onChange: (recipeSchedule) {
                          recipeSchedules[index] = recipeSchedule;
                        },
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
