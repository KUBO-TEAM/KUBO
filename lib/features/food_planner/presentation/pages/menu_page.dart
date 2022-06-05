import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu/menu_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_schedule_delete/recipe_schedule_delete_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_schedule_edit/recipe_schedule_edit_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_schedule_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MenuPage extends StatefulWidget {
  static const String id = 'menu_page';
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).add(
      CreateRecipeScheduleDialogInitializeState(),
    );

    BlocProvider.of<MenuBloc>(context).add(
      MenuRecipeScheduleFetched(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<RecipeInfoCreateRecipeScheduleBloc,
                RecipeInfoCreateRecipeScheduleState>(
              listener: (context, state) {
                if (state is RecipeInfoCreateRecipeScheduleSuccess) {
                  BlocProvider.of<MenuBloc>(context).add(
                    MenuRecipeScheduleFetched(),
                  );
                }
              },
            ),
            BlocListener<RecipeScheduleEditBloc, RecipeScheduleEditState>(
              listener: (context, state) {
                if (state is RecipeScheduleEditSuccess) {
                  BlocProvider.of<MenuBloc>(context).add(
                    MenuRecipeScheduleFetched(),
                  );
                }

                if (state is RecipeScheduleEditFailure) {
                  ArtSweetAlert.show(
                    context: context,
                    artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.danger,
                      title: "Oops...",
                      text: state.message,
                    ),
                  );
                }
              },
            ),
            BlocListener<RecipeScheduleDeleteBloc, RecipeScheduleDeleteState>(
              listener: (context, state) {
                if (state is RecipeScheduleDeleteSuccess) {
                  BlocProvider.of<MenuBloc>(context).add(
                    MenuRecipeScheduleFetched(),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<MenuBloc, MenuState>(
            builder: (context, state) {
              List<RecipeSchedule> recipeSchedules = [];

              if (state is MenuRecipeScheduleFetchInProgress) {
                final recipeScheuleCache = state.recipeSchedules;

                if (recipeScheuleCache != null) {
                  recipeSchedules = recipeScheuleCache;
                }
              }

              if (state is MenuRecipeScheduleFetchSuccess) {
                recipeSchedules = state.recipeSchedules;
              }

              if (state is MenuRecipeScheduleUpdateFetchFailure) {
                recipeSchedules = state.recipeSchedules;
              }

              if (state is MenuRecipeScheduleUpdateFetchSuccess) {
                recipeSchedules = state.recipeSchedules;
              }
              final today = DateTime.now();

              DateTime minDate = DateTime(
                today.year,
                today.month,
                today.day,
                0,
                0,
              );

              DateTime maxDate = DateTime(
                today.year,
                today.month,
                today.day + 6,
                23,
                59,
              );

              String dayToday = Utils.findDay(today);

              int numDayToday = kDayList.indexOf(dayToday);

              if (numDayToday > 0) {
                minDate = minDate.add(Duration(days: -numDayToday));
              }

              if (numDayToday <= 6 && numDayToday != 0) {
                maxDate = maxDate.add(Duration(days: 7 - numDayToday));
              }

              return RecipeScheduleCalendar(
                minDate: minDate,
                maxDate: maxDate,
                calendarView: CalendarView.week,
                recipeSchedules: recipeSchedules,
                allowDragAndDrop: true,
              );
            },
          ),
        ),
      ),
    );
  }
}
