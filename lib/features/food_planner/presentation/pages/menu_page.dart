import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu/menu_bloc.dart';
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
    return const Scaffold(
      body: SafeArea(
        child: RecipeScheduleCalendar(
          calendarView: CalendarView.week,
        ),
      ),
    );
  }
}
