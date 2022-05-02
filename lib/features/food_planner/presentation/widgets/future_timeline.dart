import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:timeline_tile/timeline_tile.dart';

class FutureTimeline extends StatelessWidget {
  const FutureTimeline({
    Key? key,
    required this.isFirst,
    required this.recipeSchedule,
  }) : super(key: key);

  final bool isFirst;
  final RecipeSchedule recipeSchedule;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      axis: TimelineAxis.horizontal,
      alignment: TimelineAlign.end,
      indicatorStyle: IndicatorStyle(
        padding: const EdgeInsets.only(bottom: 5),
        height: 30,
        color: const Color.fromARGB(255, 0, 160, 83),
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: Icons.access_time_filled,
        ),
      ),
      beforeLineStyle: const LineStyle(color: kBlackPrimary),
      afterLineStyle: const LineStyle(color: kBlackPrimary),
      startChild: Container(
        constraints: const BoxConstraints(
          minWidth: 150,
        ),
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
