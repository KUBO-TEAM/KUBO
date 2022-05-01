import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/widgets/timeline_date_container.dart';
import 'package:timeline_tile/timeline_tile.dart';

class EndingTimeline extends StatelessWidget {
  const EndingTimeline({
    Key? key,
    required this.recipeSchedule,
    required this.isStart,
  }) : super(key: key);

  final RecipeSchedule recipeSchedule;
  final bool isStart;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.center,
      isLast: true,
      indicatorStyle: IndicatorStyle(
        width: 30,
        color: kBrownPrimary,
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: Icons.hourglass_full,
        ),
      ),
      beforeLineStyle: const LineStyle(color: kBlackPrimary),
      endChild: isStart
          ? TimelineDateContainer(
              recipeSchedule: recipeSchedule,
              isStart: false,
            )
          : null,
      startChild: isStart == false
          ? TimelineDateContainer(
              recipeSchedule: recipeSchedule,
              isStart: true,
            )
          : null,
    );
  }
}
