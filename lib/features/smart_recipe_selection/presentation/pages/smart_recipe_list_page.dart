import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/user/user_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/generated_menu_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/home_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipes_page.dart';
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

  String dialogTimeFormat(RecipeSchedule recipeSchedule) {
    return '${DateFormat.jm().format(recipeSchedule.start)} - ${DateFormat.jm().format(recipeSchedule.end)} ${DateFormat.yMMMEd('en_US').format(recipeSchedule.start)}';
  }

  void _showDeleteRecipeScheduleDialog(
    int recipeScheduleArrayIndex,
    RecipeSchedule recipeSchedule,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete ?'),
        content: Text(
          'Are you sure you want to delete the schedule of ${dialogTimeFormat(recipeSchedule)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              BlocProvider.of<SmartRecipeListBloc>(context).add(
                SmartRecipeListRecipeScheduleDeleted(
                  recipeScheduleArrayIndex: recipeScheduleArrayIndex,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
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
                    UserState userState =
                        BlocProvider.of<UserBloc>(context).state;

                    if (userState is UserSuccess) {
                      BlocProvider.of<SmartRecipeListBloc>(context).add(
                        SmartRecipeListRecipeSchedulesSaved(
                          recipeSchedules: recipeSchedules,
                          user: userState.user,
                        ),
                      );
                    }
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
                    addAutomaticKeepAlives: false,
                    itemCount: state.recipeSchedules.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return SmartRecipeListTile(
                        key: ValueKey(recipeSchedules.length + index),
                        recipeSchedule: recipeSchedules[index],
                        onChange: (recipeSchedule) {
                          recipeSchedules[index] = recipeSchedule;
                        },
                        onChangeRecipe: () {
                          Navigator.pushNamed(
                            context,
                            RecipesPage.id,
                            arguments: RecipesPageArguments(
                              categories: widget.arguments.categories,
                              recipeScheduleArrayIndex: index,
                            ),
                          );
                        },
                        onDeleteRecipeSchedule: () =>
                            _showDeleteRecipeScheduleDialog(
                                index, recipeSchedules[index]),
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
