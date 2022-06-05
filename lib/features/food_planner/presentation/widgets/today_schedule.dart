import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/today_schedule/today_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_info_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/event_card.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/blocs/smart_recipe_list/smart_recipe_list_bloc.dart';

import '../blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart';

class TodaySchedule extends StatefulWidget {
  const TodaySchedule({
    Key? key,
  }) : super(key: key);

  @override
  State<TodaySchedule> createState() => _TodayScheduleState();
}

class _TodayScheduleState extends State<TodaySchedule> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<TodayScheduleBloc>(context).add(TodayScheduleFetched());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RecipeInfoCreateRecipeScheduleBloc,
            RecipeInfoCreateRecipeScheduleState>(
          listener: (context, state) {
            if (state is RecipeInfoCreateRecipeScheduleSuccess) {
              BlocProvider.of<TodayScheduleBloc>(context).add(
                TodayScheduleFetched(),
              );
            }
          },
        ),
        BlocListener<SmartRecipeListBloc, SmartRecipeListState>(
          listener: (context, state) {
            if (state is SmartRecipeListCreateSuccess) {
              BlocProvider.of<TodayScheduleBloc>(context).add(
                TodayScheduleFetched(),
              );
            }
          },
        )
      ],
      child: BlocBuilder<TodayScheduleBloc, TodayScheduleState>(
        builder: (context, state) {
          if (state is TodayScheduleSuccess) {
            final recipeSchedule = state.recipeSchedule;
            return InkWell(
              onTap: () {
                if (recipeSchedule != null) {
                  BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).add(
                    CreateRecipeScheduleDialogInitializeState(),
                  );

                  Navigator.pushNamed(
                    context,
                    RecipeInfoPage.id,
                    arguments: RecipeInfoPageArguments(
                      recipe: recipeSchedule.recipe,
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                            color: kBlackPrimary,
                            fontFamily: 'Montserrat Bold',
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMMd('en_US').format(DateTime.now()),
                          style: const TextStyle(
                            color: kBlackPrimary,
                            fontFamily: 'Montserrat',
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    EventCard(
                      eventTitle: 'Pending schedule',
                      eventIcon: Icons.pending_actions,
                      recipeSchedule: recipeSchedule,
                    )
                  ],
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
