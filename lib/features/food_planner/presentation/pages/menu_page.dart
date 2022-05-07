import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu/menu_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_info_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_selection_dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

const _calendarHeaderStyle = CalendarHeaderStyle(
  backgroundColor: kBrownPrimary,
  textAlign: TextAlign.center,
  textStyle: TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat Bold',
    fontSize: 20.0,
  ),
);

const _calendarViewHeaderStyle = ViewHeaderStyle(
  backgroundColor: kBrownPrimary,
  dayTextStyle: TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat Medium',
    fontSize: 16.0,
  ),
  dateTextStyle: TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
    fontSize: 14.0,
  ),
);

const _calendarWeekNumberStyle = WeekNumberStyle(
  textStyle: TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
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
    BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).add(
      CreateRecipeScheduleDialogDateTimeSaved(startedTime: startedTime),
    );
    _showIngredientsPickerDialog(
      context,
    );
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
    return BlocBuilder<MenuBloc, MenuState>(
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

        return Stack(
          children: [
            SfCalendar(
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
          ],
        );
      },
    );
  }
}
