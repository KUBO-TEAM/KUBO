import 'package:flutter/material.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/widgets/color_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/day_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/time_selector.dart';

class ScheduleTab extends StatelessWidget {
  const ScheduleTab({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20.0,
      ),
      child: Column(
        children: [
          DaySelector(
            list: kDayList,
            leadingIcon: Icons.calendar_today,
            onSelected: (int? i) {},
          ),
          TimeSelector(
            title: 'Start',
            onTimePicked: (TimeOfDay? startTimePicked) {},
          ),
          TimeSelector(
            title: 'End',
            onTimePicked: (TimeOfDay? startTimePicked) {},
          ),
          ColorSelector(
            // currentColor: colorPicked,
            onColorPicked: (Color? selectedColor) {
              // colorPicked = selectedColor!;
            },
          ),
        ],
      ),
    );
  }
}
