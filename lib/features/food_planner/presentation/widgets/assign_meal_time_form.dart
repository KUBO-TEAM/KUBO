import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/core/constants/snackbar_constants.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/core/hive/objects/recipe_schedule_hive.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/blocs/assign_meal/assign_meal_plan_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/recipe_schedule/recipe_schedule_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/menu_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/color_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/day_selector.dart';
import 'package:kubo/features/food_planner/presentation/widgets/square_button.dart';
import 'package:kubo/features/food_planner/presentation/widgets/time_selector.dart';

class AssignMealTimeForm extends StatefulWidget {
  const AssignMealTimeForm({
    Key? key,
    required this.schedule,
    required this.recipe,
  }) : super(key: key);

  final RecipeScheduleHive? schedule;
  final Recipe recipe;

  @override
  State<AssignMealTimeForm> createState() => _AssignMealTimeFormState();
}

class _AssignMealTimeFormState extends State<AssignMealTimeForm> {
  int day = 0;
  TimeOfDay? start;
  TimeOfDay? end;
  Color colorPicked = kGreenPrimary;

  @override
  void initState() {
    super.initState();
    _updateFormFromLocal();
  }

  void _updateFormFromLocal() {
    setState(() {
      if (widget.schedule != null) {
        day = kDayList.indexOf(
          DateFormat('EEEE').format(widget.schedule!.start),
        );
        start = _dateTimeToTimeOfDay(widget.schedule!.start);
        end = _dateTimeToTimeOfDay(widget.schedule!.end);
        colorPicked = widget.schedule!.color;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipeScheduleBloc, RecipeScheduleState>(
      listener: (context, state) {
        if (state is RecipeScheduleSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(kSuccessfullySaveSnackBar);

          Navigator.pushNamedAndRemoveUntil(
            context,
            MenuPage.id,
            (route) => route.isFirst,
          );
        } else if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(kFailedSaveSnackBar);
        }
      },
      child: BlocBuilder<AssignMealPlanBloc, AssignMealPlanState>(
        builder: (context, state) {
          if (state is AssignMealPlanSuccess) {
            TimeOfDay? startingDate = start;
            TimeOfDay? endingDate = end;

            startingDate = _dateTimeToTimeOfDay(state.startingDate);

            start = startingDate;

            endingDate = _dateTimeToTimeOfDay(
              state.startingDate.add(const Duration(hours: 1)),
            );
            end = endingDate;

            day = kDayList.indexOf(
              DateFormat('EEEE').format(state.startingDate),
            );

            BlocProvider.of<AssignMealPlanBloc>(context).add(
              AssignMealPlanStartingDateRemoved(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pick a schedule',
                style: kTitleTextStyle,
              ),
              const SizedBox(
                height: 10.0,
              ),
              DaySelector(
                list: kDayList,
                initialDay: day,
                leadingIcon: Icons.calendar_today,
                onSelected: (int? daySelected) {
                  if (daySelected != null) {
                    day = daySelected;
                  }
                },
              ),
              TimeSelector(
                title: 'Start',
                initialTime: start,
                onTimePicked: (TimeOfDay? startTimePicked) {
                  if (startTimePicked != null) {
                    setState(() {
                      start = startTimePicked;
                    });
                  }
                },
              ),
              TimeSelector(
                title: 'End',
                initialTime: end,
                onTimePicked: (TimeOfDay? endTimePicked) {
                  if (endTimePicked != null) {
                    setState(() {
                      end = endTimePicked;
                    });
                  }
                },
              ),
              ColorSelector(
                currentColor: colorPicked,
                onColorPicked: (Color? selectedColor) {
                  colorPicked = selectedColor!;
                },
              ),
              SquareButton(
                onPressed: save,
              )
            ],
          );
        },
      ),
    );
  }

  void save() {
    final recipe = widget.recipe;

    if (start != null && end != null) {
      _showConfirmationPopUp(() {
        BlocProvider.of<RecipeScheduleBloc>(context).add(
          CreateRecipeScheduleForMenu(
            id: recipe.id,
            name: recipe.name,
            day: day,
            description: recipe.description,
            imageUrl: recipe.imageUrl,
            start: start!,
            end: end!,
            color: colorPicked,
            isAllDay: false,
          ),
        );
      });
    }
  }

  void _showConfirmationPopUp(VoidCallback yesOnPressed) {
    final recipe = widget.recipe;

    final popup = BeautifulPopup(
      context: context,
      template: TemplateTerm,
    );

    popup.show(
      title: 'Wait, Are you sure?',
      content:
          'You want to save ${recipe.name} to your ${start!.format(context)} to ${end!.format(context)} meal on ${kDayList[day]} ?',
      actions: [
        popup.button(
          label: 'Yes',
          onPressed: yesOnPressed,
        ),
      ],
    );
  }

  TimeOfDay? _dateTimeToTimeOfDay(DateTime? time) {
    if (time == null) {
      return null;
    }

    return TimeOfDay(hour: time.hour, minute: time.minute);
  }
}
