import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/snackbar_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/today_schedule/today_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/tomorrow_schedule/tomorrow_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/create_recipe_schedule_dialog.dart';
import 'package:kubo/features/food_planner/presentation/widgets/ending_timeline.dart';
import 'package:kubo/features/food_planner/presentation/widgets/future_latest_timeline.dart';
import 'package:kubo/features/food_planner/presentation/widgets/future_timeline.dart';
import 'package:kubo/features/food_planner/presentation/widgets/middle_timeline.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab>
    with AutomaticKeepAliveClientMixin<ScheduleTab> {
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
    super.build(context);

    return BlocListener<RecipeInfoCreateRecipeScheduleBloc,
        RecipeInfoCreateRecipeScheduleState>(
      listener: (context, state) {
        if (state is RecipeInfoCreateRecipeScheduleSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(kSuccessfullySaveSnackBar);

          BlocProvider.of<RecipeInfoFetchRecipeSchedulesBloc>(context).add(
            RecipeInfoFetchRecipeSchedulesFetched(recipeId: widget.recipe.id),
          );

          BlocProvider.of<TomorrowScheduleBloc>(context).add(
            TomorrowScheduleFetched(),
          );

          BlocProvider.of<TodayScheduleBloc>(context).add(
            TodayScheduleFetched(),
          );
        }
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          top: 16.0,
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<RecipeInfoFetchRecipeSchedulesBloc,
              RecipeInfoFetchRecipeSchedulesState>(
            builder: (context, state) {
              if (state is RecipeInfoFetchRecipeSchedulesSuccess) {
                final pastRecipeSchedules = state.pastRecipeSchedules;
                final futureRecipeSchedules = state.futureRecipeSchedules;
                final latestRecipeSchedule = state.latestRecipeSchedule;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          RoundedButton(
                            onPressed: () {
                              _showCreateScheduleDialog();
                            },
                            title: const Text(
                              'New schedule for this recipe',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: 'Montserrat Medium',
                              ),
                            ),
                            icon: const Icon(
                              Icons.schedule,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: kGreenPrimary,
                                child: Icon(
                                  Icons.access_time_filled,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                'Upcoming',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kBlackPrimary,
                                  fontFamily: 'Montserrat Medium',
                                ),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: kGreenPrimary,
                                child: Icon(
                                  Icons.flag,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                'Most recent',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kBlackPrimary,
                                  fontFamily: 'Montserrat Medium',
                                ),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: kBrownPrimary,
                                child: Icon(
                                  Icons.hourglass_full,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                'Previous',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kBlackPrimary,
                                  fontFamily: 'Montserrat Medium',
                                ),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    SingleChildScrollView(
                      reverse: true,
                      padding: const EdgeInsets.only(left: 16.0),
                      child: SizedBox(
                        height: 90.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ...List.generate(futureRecipeSchedules.length,
                                (index) {
                              if (latestRecipeSchedule ==
                                  futureRecipeSchedules[index]) {
                                return Container();
                              }

                              if (index == 0) {
                                return FutureTimeline(
                                  isFirst: true,
                                  recipeSchedule: futureRecipeSchedules[index],
                                );
                              } else {
                                return FutureTimeline(
                                  isFirst: false,
                                  recipeSchedule: futureRecipeSchedules[index],
                                );
                              }
                            }),
                            if (latestRecipeSchedule != null)
                              FutureLatestTimeline(
                                recipeSchedule: latestRecipeSchedule,
                              )
                          ],
                        ),
                      ),
                      scrollDirection: Axis.horizontal,
                    ),
                    ...List.generate(
                      pastRecipeSchedules.length,
                      (index) {
                        if (latestRecipeSchedule ==
                            pastRecipeSchedules[index]) {
                          return Container();
                        }

                        if (index == (pastRecipeSchedules.length - 1)) {
                          return EndingTimeline(
                            recipeSchedule: pastRecipeSchedules[index],
                            isStart: index % 2 == 0 ? false : true,
                          );
                        }

                        return MiddleTimeline(
                          recipeSchedule: pastRecipeSchedules[index],
                          isStart: index % 2 == 0 ? false : true,
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

  @override
  bool get wantKeepAlive => true;
}
