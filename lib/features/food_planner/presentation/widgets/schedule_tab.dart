import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/snackbar_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/create_recipe_schedule_dialog.dart';
import 'package:kubo/features/food_planner/presentation/widgets/ending_timeline.dart';
import 'package:kubo/features/food_planner/presentation/widgets/middle_timeline.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:kubo/features/food_planner/presentation/widgets/starting_timeline.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  Future<void> _showCreateScheduleDialog() async {
    await showDialog(
      context: context,
      builder: (_) {
        return CreateRecipeScheduleDialog(
          recipe: widget.recipe,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipeInfoCreateRecipeScheduleBloc,
        RecipeInfoCreateRecipeScheduleState>(
      listener: (context, state) {
        if (state is RecipeInfoCreateRecipeScheduleSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(kSuccessfullySaveSnackBar);
          BlocProvider.of<RecipeInfoFetchRecipeSchedulesBloc>(context).add(
            RecipeInfoFetchRecipeSchedulesFetched(recipeId: widget.recipe.id),
          );
        }
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<RecipeInfoFetchRecipeSchedulesBloc,
              RecipeInfoFetchRecipeSchedulesState>(
            builder: (context, state) {
              if (state is RecipeInfoFetchRecipeSchedulesSuccess) {
                final recipeSchedules = state.recipeSchedules;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundedButton(
                      onPressed: () {
                        _showCreateScheduleDialog();
                      },
                      title: const Text('New schedule for this recipe'),
                      icon: const Icon(
                        Icons.schedule,
                        color: Colors.white,
                      ),
                    ),
                    ...List.generate(
                      recipeSchedules.length,
                      (index) {
                        if (index == 0) {
                          return StartingTimeline(
                            recipeSchedule: recipeSchedules[index],
                          );
                        } else if (index == (recipeSchedules.length - 1)) {
                          return EndingTimeline(
                            recipeSchedule: recipeSchedules[index],
                            isStart: index % 2 == 0 ? true : false,
                          );
                        }

                        return MiddleTimeline(
                          recipeSchedule: recipeSchedules[index],
                          isStart: index % 2 == 0 ? true : false,
                        );
                      },
                    ),
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
