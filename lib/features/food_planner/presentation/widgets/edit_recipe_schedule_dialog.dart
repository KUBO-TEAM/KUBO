import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_schedule_edit/recipe_schedule_edit_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/color_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/day_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/square_button.dart';
import 'package:kubo/features/food_planner/presentation/widgets/time_selector.dart';

class EditRecipeScheduleDialog extends StatefulWidget {
  const EditRecipeScheduleDialog({
    Key? key,
    required this.recipeSchedule,
  }) : super(key: key);

  final RecipeSchedule recipeSchedule;

  @override
  State<EditRecipeScheduleDialog> createState() =>
      _EditRecipeScheduleDialogState();
}

class _EditRecipeScheduleDialogState extends State<EditRecipeScheduleDialog> {
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  Color? selectedColor = kGreenPrimary;
  String? selectedDay;

  void editSchedule() {
    BlocProvider.of<RecipeScheduleEditBloc>(context).add(
      RecipeScheduleManualEdited(
        recipeSchedule: widget.recipeSchedule,
        day: selectedDay,
        start: selectedStartTime,
        end: selectedEndTime,
        color: selectedColor,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedStartTime =
          Utils.dateTimeToTimeOfDay(widget.recipeSchedule.start);
      selectedEndTime = Utils.dateTimeToTimeOfDay(widget.recipeSchedule.end);
      selectedDay = Utils.findDay(widget.recipeSchedule.start);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.maxFinite,
        height: 340,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: const EdgeInsets.only(top: 8, right: 8),
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: DaySelector(
                list: kDayList,
                initialDay: selectedDay,
                leadingIcon: Icons.calendar_today,
                onSelectedDay: (String? value) {
                  selectedDay = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: TimeSelector(
                title: 'Start',
                end: selectedEndTime,
                day: selectedDay,
                initialTimeOfDay: selectedStartTime,
                onTimePicked: (TimeOfDay? value) {
                  setState(() {
                    selectedStartTime = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: TimeSelector(
                title: 'End',
                start: selectedStartTime,
                day: selectedDay,
                initialTimeOfDay: selectedEndTime,
                onTimePicked: (TimeOfDay? value) {
                  setState(() {
                    selectedEndTime = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: ColorSelector(
                initialColor: selectedColor,
                onColorPicked: (Color? value) {
                  selectedColor = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: SquareButton(
                onPressed: editSchedule,
                title: 'Edit Schedule',
              ),
            )
          ],
        ),
      ),
    );
  }
}
