import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/calendar_style.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/helpers/calendar_schedule_datasource.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_info_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipes_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_selection_dialog.dart';
import 'package:kubo/features/food_planner/presentation/widgets/reminder_bell.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RecipeScheduleCalendar extends StatelessWidget {
  const RecipeScheduleCalendar(
      {Key? key,
      required this.calendarView,
      required this.recipeSchedules,
      this.allowDragAndDrop = false,
      this.minDate,
      this.maxDate})
      : super(key: key);

  final CalendarView calendarView;
  final List<RecipeSchedule> recipeSchedules;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool allowDragAndDrop;

  void _calendarTapped({
    required CalendarTapDetails details,
    required BuildContext context,
  }) {
    dynamic schedulesClicked = details.appointments;
    DateTime startingDate = details.date!;

    CalendarElement element = details.targetElement;
    if (schedulesClicked != null && schedulesClicked.isNotEmpty) {
      _navigateToScheduledMeal(context, schedulesClicked.first);
    } else if (element == CalendarElement.calendarCell) {
      _cellPressed(context, startingDate);
    }
  }

  void _navigateToScheduledMeal(
    BuildContext context,
    RecipeSchedule recipeSchedule,
  ) {
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

  void _cellPressed(
    BuildContext context,
    DateTime startedTime,
  ) {
    int daysBetween = Utils.daysBetween(DateTime.now(), startedTime);
    if (daysBetween >= 0 &&
        daysBetween < 7 &&
        Utils.hoursBetween(DateTime.now(), startedTime) >= 0) {
      BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).add(
        CreateRecipeScheduleDialogDateTimeSaved(startedTime: startedTime),
      );
      _showIngredientsPickerDialog(
        context,
      );
    } else {
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Oops...",
          text: "You can't schedule on that cell.",
        ),
      );
    }
  }

  void _showIngredientsPickerDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RecipeSelectionDialog(
          actionButton: (selectedCategories) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                RoundedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RecipesPage.id,
                      arguments: RecipesPageArguments(
                        categories: selectedCategories,
                      ),
                    );
                  },
                  title: const Text(
                    'Proceed to recipe selection',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat Medium',
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfCalendar(
          allowDragAndDrop: allowDragAndDrop,
          minDate: minDate,
          maxDate: maxDate,
          todayHighlightColor: kGreenPrimary,
          dataSource: CalenderScheduleDataSource(
            recipeSchedules: recipeSchedules,
            context: context,
          ),
          timeSlotViewSettings: kCalendarTimeSlotViewSettings,
          headerStyle: kCalendarHeaderStyle,
          viewHeaderStyle: kCalendarViewHeaderStyle,
          view: calendarView,
          weekNumberStyle: kCalendarWeekNumberStyle,
          firstDayOfWeek: 1,
          onTap: (CalendarTapDetails details) {
            _calendarTapped(
              details: details,
              context: context,
            );
          },
          scheduleViewMonthHeaderBuilder: (
            BuildContext buildContext,
            ScheduleViewMonthHeaderDetails details,
          ) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/calendar/${DateFormat.M().format(details.date)}.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                '${DateFormat.MMMM().format(details.date)}, ${details.date.year.toString()}',
                style: const TextStyle(
                  fontFamily: 'BebasNeue',
                  letterSpacing: 5,
                  fontSize: 20.0,
                  color: kBlackPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
        IconButton(
          padding: const EdgeInsets.only(
            left: 10.0,
            bottom: 10.0,
          ),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const Positioned(
          right: -5,
          top: -5,
          child: ReminderBell(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
