import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_info_icon_with_text.dart';

class RecipeInfoPagePreviewInfo extends StatelessWidget {
  const RecipeInfoPagePreviewInfo({Key? key, required this.recipe})
      : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<RecipeInfoFetchRecipeSchedulesBloc,
              RecipeInfoFetchRecipeSchedulesState>(
            builder: (context, state) {
              String schedule = 'No schedule';
              if (state is RecipeInfoFetchRecipeSchedulesSuccess &&
                  state.latestRecipeSchedule != null) {
                final latestSchedule = state.latestRecipeSchedule;

                schedule =
                    '${DateFormat.yMMMEd('en_US').format(latestSchedule!.start)} ${DateFormat.jm('en_US').format(latestSchedule.start)} - ${DateFormat.jm('en_US').format(latestSchedule.end)} ';
              }
              return Text(
                schedule,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              );
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RecipeInfoIconWithText(
                icon: Icons.outdoor_grill,
                title: 'Cook Time',
                data: recipe.cookTime.toString(),
                color: Colors.white,
              ),
              RecipeInfoIconWithText(
                icon: Icons.hourglass_top,
                title: 'Prep Time',
                data: recipe.prepTime.toString(),
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RecipeInfoIconWithText(
                icon: Icons.restaurant,
                data: recipe.course,
                color: Colors.white,
              ),
              RecipeInfoIconWithText(
                icon: Icons.brunch_dining,
                data: recipe.cuisine,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
