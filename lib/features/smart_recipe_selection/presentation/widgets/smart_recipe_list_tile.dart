import 'package:flutter/material.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/widgets/color_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/day_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/time_selector.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/smart_recipe_list_tile_recipe_card.dart';
import 'package:skeletons/skeletons.dart';

class SmartRecipeListTile extends StatelessWidget {
  const SmartRecipeListTile({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 8.0,
      ),
      width: 350,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SmartRecipeListTileRecipeCard(recipe: recipe),
            DaySelector(
              list: kDayList,
              leadingIcon: Icons.calendar_today,
              onSelectedDay: (int? i) {},
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
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

class SmartRecipeListSkeleton extends StatelessWidget {
  const SmartRecipeListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          right: 10.0,
        ),
        width: 350,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 350,
              child: Card(
                elevation: 0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: SkeletonAvatar(),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                      lines: 3,
                      spacing: 6,
                      lineStyle: SkeletonLineStyle(
                        randomLength: true,
                        height: 10,
                        borderRadius: BorderRadius.circular(8),
                        minLength: 200,
                        maxLength: 300,
                      ),
                    ),
                  ),
                  const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 350,
                      height: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 350,
                      height: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 350,
                      height: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 350,
                      height: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
