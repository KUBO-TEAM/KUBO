import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/food_planner/presentation/blocs/user/user_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_info/recipe_info_create_recipe_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/color_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/day_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/square_button.dart';
import 'package:kubo/features/food_planner/presentation/widgets/time_selector.dart';

class CreateRecipeScheduleDialog extends StatefulWidget {
  const CreateRecipeScheduleDialog({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  State<CreateRecipeScheduleDialog> createState() =>
      _CreateRecipeScheduleDialogState();
}

class _CreateRecipeScheduleDialogState
    extends State<CreateRecipeScheduleDialog> {
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  Color? selectedColor = kGreenPrimary;
  String selectedDay = Utils.findDay(DateTime.now());

  void saveSchedule() {
    UserState userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserSuccess) {
      User user = userState.user;

      BlocProvider.of<RecipeInfoCreateRecipeScheduleBloc>(context).add(
        RecipeInfoCreateRecipeScheduleCreated(
          recipe: widget.recipe,
          day: selectedDay,
          start: selectedStartTime,
          end: selectedEndTime,
          color: selectedColor,
          user: user,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    final createRecipeDialogState =
        BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).state;

    if (createRecipeDialogState is CreateRecipeScheduleDialogSuccess) {
      setState(() {
        selectedStartTime = createRecipeDialogState.start;
        selectedEndTime = createRecipeDialogState.end;
        selectedDay = createRecipeDialogState.day;
      });
    }
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
                onSelectedDay: (String value) {
                  setState(() {
                    selectedDay = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: TimeSelector(
                title: 'Start',
                day: selectedDay,
                end: selectedEndTime,
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
                onPressed: saveSchedule,
                title: 'Save Schedule',
              ),
            )
          ],
        ),
      ),
    );
  }
}
