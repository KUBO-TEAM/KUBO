import 'package:flutter/material.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/widgets/generated_recipe_schedule_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class GeneratedMenuPageArguments {
  final List<RecipeSchedule> recipeSchedules;

  const GeneratedMenuPageArguments({required this.recipeSchedules});
}

class GeneratedMenuPage extends StatelessWidget {
  static const String id = 'generated_menu_page';
  const GeneratedMenuPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final GeneratedMenuPageArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GeneratedRecipeScheduleCalendar(
          calendarView: CalendarView.week,
          recipeSchedules: arguments.recipeSchedules,
        ),
      ),
    );
  }
}
