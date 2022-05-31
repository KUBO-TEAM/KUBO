import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/agenda/agenda_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/recipe_schedule_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AgendaPage extends StatefulWidget {
  static const String id = 'agenda_page';
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).add(
      CreateRecipeScheduleDialogInitializeState(),
    );
    BlocProvider.of<AgendaBloc>(context).add(
      AgendaRecipeSchedulesFetched(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AgendaBloc, AgendaState>(
          builder: (context, state) {
            List<RecipeSchedule> recipeSchedules = [];

            if (state is AgendaFetchInProgress) {
              final recipeScheuleCache = state.recipeSchedules;

              recipeSchedules = recipeScheuleCache;
            }

            if (state is AgendaFetchSuccess) {
              recipeSchedules = state.recipeSchedules;
            }

            if (state is AgendaUpdateFetchFailure) {
              recipeSchedules = state.recipeSchedules;
            }

            if (state is AgendaUpdateFetchSuccess) {
              recipeSchedules = state.recipeSchedules;
            }

            return RecipeScheduleCalendar(
              calendarView: CalendarView.schedule,
              recipeSchedules: recipeSchedules,
            );
          },
        ),
      ),
    );
  }
}
