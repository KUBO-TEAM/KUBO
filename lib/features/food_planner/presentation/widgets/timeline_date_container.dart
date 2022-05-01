import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';

class TimelineDateContainer extends StatelessWidget {
  const TimelineDateContainer({
    Key? key,
    required this.recipeSchedule,
    required this.isStart,
  }) : super(key: key);

  final RecipeSchedule recipeSchedule;
  final bool isStart;

  @override
  Widget build(BuildContext context) {
    final columnAlignment =
        isStart ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final titleContainerAlignment =
        isStart ? Alignment.bottomRight : Alignment.bottomLeft;

    return Container(
      padding: const EdgeInsets.only(
        left: 7.5,
        right: 7.5,
        top: 20.0,
      ),
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      // alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: columnAlignment,
        children: [
          Expanded(
            child: Container(
              alignment: titleContainerAlignment,
              child: Text(
                DateFormat.yMMMEd('en_US').format(recipeSchedule.start),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: Text(
              '${DateFormat.jm().format(recipeSchedule.start)} - ${DateFormat.jm().format(recipeSchedule.end)}',
              style: const TextStyle(
                fontSize: 13.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
