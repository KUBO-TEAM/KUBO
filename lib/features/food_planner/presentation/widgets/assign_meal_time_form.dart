import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kubo/constants/colors_constants.dart';
import 'package:kubo/constants/list_costants.dart';
import 'package:kubo/constants/snackbar_constants.dart';
import 'package:kubo/constants/text_styles_constants.dart';
import 'package:kubo/core/hive/objects/schedule.hive.dart';
import 'package:kubo/core/temp/recipe.dart';
import 'package:kubo/features/food_planner/presentation/blocs/assign_meal/meal_plan_cubit.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu/menu_cubit.dart';
import 'package:kubo/features/food_planner/presentation/pages/menu_page.dart';
import 'package:kubo/widgets/buttons/square.button.dart';
import 'package:kubo/widgets/selectors/color.selector.dart';
import 'package:kubo/widgets/selectors/day.selector.dart';
import 'package:kubo/widgets/selectors/time.selector.dart';

class AssignMealTimeForm extends StatefulWidget {
  const AssignMealTimeForm({
    Key? key,
    required this.schedule,
    required this.recipe,
  }) : super(key: key);

  final ScheduleHive? schedule;
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
          DateFormat('EEEE').format(widget.schedule!.startTime),
        );
        start = _dateTimeToTimeOfDay(widget.schedule!.startTime);
        end = _dateTimeToTimeOfDay(widget.schedule!.endTime);
        colorPicked = widget.schedule!.color;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealPlanCubit, MealPlanState>(
      builder: (context, state) {
        if (state is CellDateSetSuccess) {
          TimeOfDay? startingDate = start;
          TimeOfDay? endingDate = end;

          startingDate = _dateTimeToTimeOfDay(state.startingDate);
          start = startingDate;

          endingDate = _dateTimeToTimeOfDay(
            state.startingDate!.add(const Duration(hours: 1)),
          );
          end = endingDate;

          day = kDayList.indexOf(
            DateFormat('EEEE').format(state.startingDate!),
          );

          BlocProvider.of<MealPlanCubit>(context).removeCellDate();
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
                  start = startTimePicked;
                }
              },
            ),
            TimeSelector(
              title: 'End',
              initialTime: end,
              onTimePicked: (TimeOfDay? endTimePicked) {
                if (endTimePicked != null) {
                  end = endTimePicked;
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
              onPressed: () => onSave(
                recipe: widget.recipe,
                start: start,
                end: end,
                day: day,
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> onSave(
      {Recipe? recipe, TimeOfDay? start, TimeOfDay? end, int? day}) async {
    if (recipe != null && start != null && end != null && day != null) {
      final popup = BeautifulPopup(
        context: context,
        template: TemplateTerm,
      );

      popup.show(
        title: 'Wait, Are you sure?',
        content:
            'You want to save ${recipe.name} to your ${start.format(context)} to ${end.format(context)} meal on ${kDayList[day]} ?',
        actions: [
          popup.button(
            label: 'Yes',
            onPressed: () {
              if (widget.schedule == null) {
                BlocProvider.of<MenuCubit>(context).addSchedule(
                  recipe: recipe,
                  start: start,
                  end: end,
                  day: day,
                  colorPicked: colorPicked,
                );

                ScaffoldMessenger.of(context)
                    .showSnackBar(kSuccessfullySaveSnackBar);

                Navigator.pushNamedAndRemoveUntil(
                    context, MenuPage.id, (route) => route.isFirst);
              } else {
                BlocProvider.of<MenuCubit>(context).updateSchedule(
                  schedule: widget.schedule!,
                  recipe: recipe,
                  start: start,
                  end: end,
                  day: day,
                  colorPicked: colorPicked,
                );

                ScaffoldMessenger.of(context)
                    .showSnackBar(kSuccessfullySaveSnackBar);

                Navigator.pushNamedAndRemoveUntil(
                    context, MenuPage.id, (route) => route.isFirst);
              }
            },
          ),
        ],
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(kFailedSaveSnackBar);
    }
  }

  TimeOfDay? _dateTimeToTimeOfDay(DateTime? time) {
    if (time == null) {
      return null;
    }

    return TimeOfDay(hour: time.hour, minute: time.minute);
  }
}
