import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/color_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/day_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/square_button.dart';
import 'package:kubo/features/food_planner/presentation/widgets/time_selector.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  Color? selectedColor;
  int? selecetdDay;

  void saveSchedule() {
    BlocProvider.of<RecipeInfoBloc>(context).add(
      RecipeInfoRecipeScheduleCreated(
        recipeId: widget.recipe.id,
        day: selecetdDay,
        start: selectedStartTime,
        end: selectedEndTime,
        color: selectedColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DaySelector(
              list: kDayList,
              leadingIcon: Icons.calendar_today,
              onSelectedDay: (int? value) {
                selecetdDay = value;
              },
            ),
            TimeSelector(
              title: 'Start',
              onTimePicked: (TimeOfDay? value) {
                selectedStartTime = value;
              },
            ),
            TimeSelector(
              title: 'End',
              onTimePicked: (TimeOfDay? value) {
                selectedEndTime = value;
              },
            ),
            ColorSelector(
              // currentColor: colorPicked,
              onColorPicked: (Color? value) {
                selectedColor = value;
              },
            ),
            SquareButton(
              onPressed: saveSchedule,
              title: 'Save Schedule',
            )
          ],
        ),
      ),
    );
  }
}
