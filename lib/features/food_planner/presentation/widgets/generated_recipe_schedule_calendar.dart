import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/calendar_style.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/helpers/calendar_schedule_datasource.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_info_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/reminder_bell.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class GeneratedRecipeScheduleCalendar extends StatelessWidget {
  const GeneratedRecipeScheduleCalendar({
    Key? key,
    required this.calendarView,
    required this.recipeSchedules,
  }) : super(key: key);

  final CalendarView calendarView;
  final List<RecipeSchedule> recipeSchedules;

  void _calendarTapped({
    required CalendarTapDetails details,
    required BuildContext context,
    required List<RecipeSchedule> recipeSchedules,
  }) {
    dynamic schedulesClicked = details.appointments;

    CalendarElement element = details.targetElement;
    if (schedulesClicked != null && schedulesClicked.isNotEmpty) {
      _navigateToScheduledMeal(context, schedulesClicked.first);
    } else if (element == CalendarElement.calendarCell) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 141, 87, 0),
          content: Row(
            children: const [
              Icon(
                Icons.priority_high,
                color: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "View only, schedule is not allowed",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfCalendar(
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
              recipeSchedules: recipeSchedules,
            );
          },
          scheduleViewMonthHeaderBuilder: (
            BuildContext buildContext,
            ScheduleViewMonthHeaderDetails details,
          ) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/calendar/1.webp"),
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
