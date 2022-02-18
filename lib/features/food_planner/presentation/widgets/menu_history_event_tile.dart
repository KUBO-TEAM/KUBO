import 'package:flutter/material.dart';
import 'package:kubo/core/constants/menu_constants.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';

class MenuHistoryListTile extends StatelessWidget {
  const MenuHistoryListTile({
    Key? key,
    required this.recipeSchedule,
    this.isLast = false,
  }) : super(key: key);

  final RecipeSchedule recipeSchedule;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            const Expanded(
              child: VerticalDivider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            CircleAvatar(
              backgroundColor: recipeSchedule.color,
              radius: 5,
            ),
            if (!isLast)
              const Expanded(
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              )
            else
              Expanded(
                child: Container(),
              ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '7:00 - 8:00 am',
              style: kCaptionTextStyle,
            ),
            Text(
              recipeSchedule.name,
              style: kPreSubTitleTextStyle,
            ),
          ],
        )
      ],
    );
  }
}
