import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kubo/constants/colors_constants.dart';
import 'package:kubo/constants/sizes_constants.dart';
import 'package:kubo/modules/meal_plan/bloc/meal_plan_cubit.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:kubo/modules/meal_plan/screens/assign_meal_time.screen.dart';
import 'package:kubo/modules/meal_plan/screens/select_ingredients.screen.dart';
import 'package:kubo/modules/menu/bloc/menu_cubit.dart';
import 'package:kubo/modules/menu/models/schedule.model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MenuScreen extends StatelessWidget {
  static const String id = 'menu_screen';
  const MenuScreen({Key? key}) : super(key: key);

  void _navigateToScheduledMeal(BuildContext context, dynamic schedule) {
    Navigator.pushNamed(
      context,
      AssignMealTimeScreen.id,
      arguments: AssignMealTimeScreenArguments(
        recipe: Recipe(
          id: schedule.first.recipeId,
          name: schedule.first.recipeName,
          description: schedule.first.recipeDescription,
          imageUrl: schedule.first.recipeImageUrl,
        ),
      ),
    );
  }

  void _selectIngredientsScreenWithStartingDate(
      BuildContext context, DateTime startingDate) {
    BlocProvider.of<MealPlanCubit>(context).setCellDate(startingDate);

    Navigator.pushNamed(context, SelectIngredientsScreen.id).then(
      (_) => BlocProvider.of<MealPlanCubit>(context).removeCellDate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: kGreenPrimary,
        animatedIcon: AnimatedIcons.menu_close,
        animationSpeed: 800,
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.menu_book,
              color: kBrownPrimary,
            ),
            label: 'Create meal plan',
            onTap: () {
              Navigator.pushNamed(context, SelectIngredientsScreen.id);
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.fact_check,
              color: kBrownPrimary,
            ),
            label: 'Ingredients',
          ),
        ],
      ),
      appBar: PreferredSize(
        preferredSize: kAppBarPrefferedSize,
        child: AppBar(
          backgroundColor: kBackgroundGrey,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: kBlackPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: const Text(
            'Menu',
            style: TextStyle(
              color: kBlackPrimary,
              fontFamily: 'Pushster',
              fontSize: 30.0,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<MenuCubit, MenuState>(builder: (context, state) {
          if ((state is MenuLoaded) == false) {
            return const Center(child: CircularProgressIndicator());
          }

          final schedules = (state as MenuLoaded).schedules;

          return SfCalendar(
            todayHighlightColor: Colors.green,
            dataSource: ScheduleDataSource(schedules),
            timeSlotViewSettings: const TimeSlotViewSettings(
              timeIntervalHeight: 70,
            ),
            headerStyle: const CalendarHeaderStyle(
              backgroundColor: kBrownPrimary,
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Lora',
                fontSize: 24,
              ),
            ),
            viewHeaderStyle: const ViewHeaderStyle(
              backgroundColor: kBrownPrimary,
              dateTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Arvo',
              ),
              dayTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Arvo',
              ),
            ),
            view: CalendarView.week,
            weekNumberStyle: const WeekNumberStyle(
              textStyle: TextStyle(
                fontFamily: 'Arvo',
              ),
            ),
            firstDayOfWeek: 1,
            onTap: (CalendarTapDetails details) {
              dynamic schedule = details.appointments;
              DateTime startingDate = details.date!;
              CalendarElement element = details.targetElement;
              if (schedule != null) {
                _navigateToScheduledMeal(context, schedule);
              } else if (element == CalendarElement.calendarCell) {
                _selectIngredientsScreenWithStartingDate(context, startingDate);
              }
            },
          );
        }),
      ),
    );
  }
}

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Schedule>? source) {
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
    return appointments![index].recipeName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].backgroundColor;
  }
}
