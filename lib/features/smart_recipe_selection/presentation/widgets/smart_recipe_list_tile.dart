import 'package:flutter/material.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/widgets/color_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/day_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/time_selector.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/widgets/smart_recipe_list_tile_recipe_card.dart';
import 'package:skeletons/skeletons.dart';

class SmartRecipeListTile extends StatefulWidget {
  const SmartRecipeListTile({
    Key? key,
    required this.recipeSchedule,
  }) : super(key: key);

  final RecipeSchedule recipeSchedule;

  @override
  State<SmartRecipeListTile> createState() => _SmartRecipeListTileState();
}

class _SmartRecipeListTileState extends State<SmartRecipeListTile> {
  TimeOfDay? selectedStartTime;

  TimeOfDay? selectedEndTime;

  Color? selectedColor;

  int? selectedDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      selectedStartTime = Utils.dateTimeToTimeOfDay(
        widget.recipeSchedule.start,
      );
      selectedEndTime = Utils.dateTimeToTimeOfDay(
        widget.recipeSchedule.end,
      );
      selectedDay = kDayList.indexOf(
        Utils.findDay(widget.recipeSchedule.start),
      );
    });
  }

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
            SmartRecipeListTileRecipeCard(recipe: widget.recipeSchedule.recipe),
            DaySelector(
              list: kDayList,
              initialDay: selectedDay,
              leadingIcon: Icons.calendar_today,
              onSelectedDay: (int? value) {
                selectedDay = value;
              },
            ),
            TimeSelector(
              title: 'Start',
              initialTimeOfDay: selectedStartTime,
              onTimePicked: (TimeOfDay? value) {
                selectedStartTime = value;
              },
            ),
            TimeSelector(
              title: 'End',
              initialTimeOfDay: selectedEndTime,
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
