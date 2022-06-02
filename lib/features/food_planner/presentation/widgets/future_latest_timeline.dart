import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';

class FutureLatestTimeline extends StatelessWidget {
  const FutureLatestTimeline({
    Key? key,
    required this.recipeSchedule,
    required this.onPressed,
  }) : super(key: key);

  final RecipeSchedule recipeSchedule;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: kGreenPrimary,
            child: Icon(
              Icons.flag,
              color: Colors.white,
            ),
          ),
          Container(
            height: double.infinity,
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 4.0,
            ),
            width: MediaQuery.of(context).size.width * .5 - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.yMMMEd('en_US').format(recipeSchedule.start),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${DateFormat.jm().format(recipeSchedule.start)} - ${DateFormat.jm().format(recipeSchedule.end)}',
                  style: const TextStyle(fontSize: 13.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
