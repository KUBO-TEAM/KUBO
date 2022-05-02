import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
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
  Color? selectedColor;
  int? selecetdDay;

  void saveSchedule() {
    BlocProvider.of<RecipeInfoCreateRecipeScheduleBloc>(context).add(
      RecipeInfoCreateRecipeScheduleCreated(
        recipe: widget.recipe,
        day: selecetdDay,
        start: selectedStartTime,
        end: selectedEndTime,
        color: selectedColor,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DirectSelectContainer(
      child: AlertDialog(
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
                  leadingIcon: Icons.calendar_today,
                  onSelectedDay: (int? value) {
                    selecetdDay = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: TimeSelector(
                  title: 'Start',
                  onTimePicked: (TimeOfDay? value) {
                    selectedStartTime = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: TimeSelector(
                  title: 'End',
                  onTimePicked: (TimeOfDay? value) {
                    selectedEndTime = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: ColorSelector(
                  // currentColor: colorPicked,
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
      ),
    );
  }
}