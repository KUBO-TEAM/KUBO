import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu/menu_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_selection_dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// TODO: When cell click show create recipe dialog automatically and go to the schedule tab automatically
// TODO: Clicking scheduled cell redirects to the recipe schedule without automatically opening the create dialog
// TODO: Arrow back button

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
    BlocProvider.of<MenuBloc>(context).add(
      MenuRecipeScheduleFetched(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: MenuPageCalendar(),
      ),
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
    return appointments![index].recipe.name;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }
}

class MenuPageCalendar extends StatelessWidget {
  const MenuPageCalendar({Key? key}) : super(key: key);

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
    // );
  }

  void _cellPressed(
    BuildContext context,
    DateTime startingDate,
  ) {
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      listener: (context, state) {
        if (state is MenuRecipeScheduleUpdateFetchFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kBrownPrimary,
              content: Row(
                children: const [
                  Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Fail to update recipe, let's try it later",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is MenuRecipeScheduleUpdateFetchSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kGreenPrimary,
              content: Row(
                children: const [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Successfully update your scheduled recipes',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }
      },
      builder: (_, state) {
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

        return SfCalendar(
          todayHighlightColor: Colors.green,
          dataSource: ScheduleDataSource(recipeSchedules),
          timeSlotViewSettings: _calendarTimeSlotViewSettings,
          headerStyle: _calendarHeaderStyle,
          viewHeaderStyle: _calendarViewHeaderStyle,
          view: CalendarView.week,
          weekNumberStyle: _calendarWeekNumberStyle,
          firstDayOfWeek: 1,
          onTap: (CalendarTapDetails details) {
            _calendarTapped(
              details: details,
              context: context,
              recipeSchedules: recipeSchedules,
            );
          },
        );
      },
    );
  }
}
