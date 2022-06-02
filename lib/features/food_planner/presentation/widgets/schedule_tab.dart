import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_fetch_recipe_schedules_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_schedule_delete/recipe_schedule_delete_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_schedule_edit/recipe_schedule_edit_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/create_recipe_schedule_dialog.dart';
import 'package:kubo/features/food_planner/presentation/widgets/edit_recipe_schedule_dialog.dart';
import 'package:kubo/features/food_planner/presentation/widgets/empty_state.dart';
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

  String dialogTimeFormat(RecipeSchedule recipeSchedule) {
    return '${DateFormat.jm().format(recipeSchedule.start)} - ${DateFormat.jm().format(recipeSchedule.end)} ${DateFormat.yMMMEd('en_US').format(recipeSchedule.start)}';
  }

  void _showEditOrDeleteDialog(RecipeSchedule recipeSchedule) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit or Delete ?'),
        content: Text(
          'Do you want to edit or delete the schedule of ${dialogTimeFormat(recipeSchedule)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) {
                  return EditRecipeScheduleDialog(
                    recipeSchedule: recipeSchedule,
                  );
                },
              );
            },
            child: const Text('Edit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showDeleteConfirmation(recipeSchedule);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(RecipeSchedule recipeSchedule) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Are you sure ?'),
        content: Text(
          'Are you sure you want to delete the schedule of ${dialogTimeFormat(recipeSchedule)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              BlocProvider.of<RecipeScheduleDeleteBloc>(context).add(
                RecipeScheduleDeleted(recipeSchedule: recipeSchedule),
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

  void _refetchRecipeSchedules(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kGreenPrimary,
        duration: const Duration(milliseconds: 1500),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );

    BlocProvider.of<RecipeInfoFetchRecipeSchedulesBloc>(context).add(
      RecipeInfoFetchRecipeSchedulesFetched(
        recipeId: widget.recipe.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<RecipeInfoCreateRecipeScheduleBloc,
            RecipeInfoCreateRecipeScheduleState>(
          listener: (context, state) {
            if (state is RecipeInfoCreateRecipeScheduleSuccess) {
              _refetchRecipeSchedules(state.message);
            }
          },
        ),
        BlocListener<RecipeScheduleEditBloc, RecipeScheduleEditState>(
          listener: (context, state) {
            if (state is RecipeScheduleEditSuccess) {
              _refetchRecipeSchedules(state.message);
            }
          },
        ),
        BlocListener<RecipeScheduleDeleteBloc, RecipeScheduleDeleteState>(
          listener: (context, state) {
            if (state is RecipeScheduleDeleteSuccess) {
              _refetchRecipeSchedules(state.message);
            }
          },
        ),
      ],
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
                    if (pastRecipeSchedules.isEmpty &&
                        futureRecipeSchedules.isEmpty &&
                        latestRecipeSchedule == null)
                      const EmptyState(
                        message: 'No schedules found',
                        assetImageUrl: "assets/images/empty_2.png",
                        imageSize: 200,
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
                                  onPressed: () {
                                    _showEditOrDeleteDialog(
                                        futureRecipeSchedules[index]);
                                  },
                                );
                              } else {
                                return FutureTimeline(
                                  isFirst: false,
                                  recipeSchedule: futureRecipeSchedules[index],
                                  onPressed: () {
                                    _showEditOrDeleteDialog(
                                        futureRecipeSchedules[index]);
                                  },
                                );
                              }
                            }),
                            if (latestRecipeSchedule != null)
                              FutureLatestTimeline(
                                recipeSchedule: latestRecipeSchedule,
                                onPressed: () {
                                  _showEditOrDeleteDialog(
                                    latestRecipeSchedule,
                                  );
                                },
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
                            onPressed: () {},
                          );
                        }

                        return MiddleTimeline(
                          recipeSchedule: pastRecipeSchedules[index],
                          isStart: index % 2 == 0 ? false : true,
                          onPressed: () {},
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
