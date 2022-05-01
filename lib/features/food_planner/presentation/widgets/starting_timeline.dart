import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StartingTimeline extends StatelessWidget {
  const StartingTimeline({
    Key? key,
    required this.recipeSchedule,
  }) : super(key: key);

  final RecipeSchedule recipeSchedule;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.center,
      isFirst: true,
      afterLineStyle: const LineStyle(color: kBlackPrimary),
      indicatorStyle: IndicatorStyle(
        width: 45,
        color: kGreenPrimary,
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: Icons.flag,
        ),
      ),
      endChild: Container(
        padding: const EdgeInsets.only(
          left: 7.5,
          right: 7.5,
          top: 25.0,
        ),
        constraints: const BoxConstraints(
          minHeight: 100,
        ),
        // alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  DateFormat.yMMMEd('en_US').format(recipeSchedule.start),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
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
                style: const TextStyle(fontSize: 13.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
