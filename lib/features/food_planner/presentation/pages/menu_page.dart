import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/assign_meal/assign_meal_plan_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu/menu_bloc.dart.old';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_selection_dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

const _calendarHeaderStyle = CalendarHeaderStyle(
  backgroundColor: kBrownPrimary,
  textAlign: TextAlign.center,
  textStyle: TextStyle(
    color: Colors.white,
    fontFamily: 'Lora',
    fontSize: 24,
  ),
);

const _calendarViewHeaderStyle = ViewHeaderStyle(
  backgroundColor: kBrownPrimary,
  dateTextStyle: TextStyle(
    color: Colors.white,
    fontFamily: 'Arvo',
  ),
  dayTextStyle: TextStyle(
    color: Colors.white,
    fontFamily: 'Arvo',
  ),
);

const _calendarWeekNumberStyle = WeekNumberStyle(
  textStyle: TextStyle(
    fontFamily: 'Arvo',
  ),
);

const _calendarTimeSlotViewSettings = TimeSlotViewSettings(
  timeIntervalHeight: 70,
);

class MenuPage extends StatelessWidget {
  static const String id = 'menu_page';
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      // body: SafeArea(
      //   child: BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
      //     if (state is MenuSuccess) {
      //       final recipeSchedules = state.recipeSchedules;

      //       return SfCalendar(
      //         todayHighlightColor: Colors.green,
      //         dataSource: ScheduleDataSource(recipeSchedules),
      //         timeSlotViewSettings: _calendarTimeSlotViewSettings,
      //         headerStyle: _calendarHeaderStyle,
      //         viewHeaderStyle: _calendarViewHeaderStyle,
      //         view: CalendarView.week,
      //         weekNumberStyle: _calendarWeekNumberStyle,
      //         firstDayOfWeek: 1,
      //         onTap: (CalendarTapDetails details) {
      //           _calendarTapped(
      //             details: details,
      //             context: context,
      //             recipeSchedules: recipeSchedules,
      //           );
      //         },
      //       );
      //     }

      //     return const Center(child: CircularProgressIndicator());
      //   }),
      // ),
    );
  }

  void _calendarTapped({
    required CalendarTapDetails details,
    required BuildContext context,
    required List<RecipeSchedule> recipeSchedules,
  }) {
    dynamic schedule = details.appointments;
    DateTime startingDate = details.date!;
    CalendarElement element = details.targetElement;
    if (schedule != null) {
      _navigateToScheduledMeal(context, schedule);
    } else if (element == CalendarElement.calendarCell) {
      _cellPressed(context, startingDate);
    }
  }

  void _navigateToScheduledMeal(
    BuildContext context,
    dynamic recipeSchedule,
  ) {
    // Navigator.pushNamed(
    //   context,
    //   AssignMealTimePage.id,
    //   arguments: AssignMealTimePageArguments(
    //     recipe: Recipe(
    //       id: recipeSchedule.first.id,
    //       name: recipeSchedule.first.name,
    //       description: recipeSchedule.first.description,
    //       displayPhoto: recipeSchedule.first.displayPhoto,
    //     ),
    //   ),
    // );
  }

  void _cellPressed(
    BuildContext context,
    DateTime startingDate,
  ) {
    BlocProvider.of<AssignMealPlanBloc>(context).add(
      AssignMealPlanCellPressed(startingDate: startingDate),
    );

    _showIngredientsPickerDialog(context);
  }

  Future<void> _showIngredientsPickerDialog(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const RecipeSelectionDialog();
      },
    );
  }
}

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<RecipeSchedule>? source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].start;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].end;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].name;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }
}
