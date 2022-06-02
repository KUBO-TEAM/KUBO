import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/presentation/widgets/picker_card.dart';

class TimeSelector extends StatefulWidget {
  const TimeSelector({
    Key? key,
    required this.title,
    required this.onTimePicked,
    required this.day,
    this.initialTimeOfDay,
    this.start,
    this.end,
  }) : super(key: key);

  final String title;
  final Function(TimeOfDay?) onTimePicked;
  final TimeOfDay? initialTimeOfDay;
  final String? day;
  final TimeOfDay? start;
  final TimeOfDay? end;

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  TimeOfDay? selectedTime;

  double _toTimeOfDayDouble(TimeOfDay myTime) =>
      myTime.hour + myTime.minute / 60.0;

  @override
  Widget build(BuildContext context) {
    final selectedTimeOrInitial = selectedTime ?? widget.initialTimeOfDay;

    return InkWell(
      onTap: () async {
        TimeOfDay? timeSelected = await showTimePicker(
          initialTime: selectedTimeOrInitial ?? TimeOfDay.now(),
          context: context,
        );

        final day = widget.day;
        final start = widget.start;
        final end = widget.end;

        if (timeSelected != null && day != null) {
          final startDateTime = Utils.convertStartTimeOfDay(
            day: day,
            startTimeOfDay: timeSelected,
          );
          if (start != null) {
            if (_toTimeOfDayDouble(start) >= _toTimeOfDayDouble(timeSelected)) {
              ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.danger,
                  title: "Oops...",
                  text:
                      "You can't schedule where the end time is less than or equal to the start time",
                ),
              );

              return;
            }
          }

          if (end != null) {
            if (_toTimeOfDayDouble(end) <= _toTimeOfDayDouble(timeSelected)) {
              ArtSweetAlert.show(
                context: context,
                artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.danger,
                  title: "Oops...",
                  text:
                      "You can't schedule where the start time is greater than or equal to the end time",
                ),
              );

              return;
            }
          }

          if (startDateTime.isBefore(DateTime.now())) {
            ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Oops...",
                text: "You can't schedule in the past, and above 1 week",
              ),
            );
          } else {
            setState(() {
              selectedTime = timeSelected;
            });

            widget.onTimePicked(timeSelected);
          }
        }
      },
      child: PickerCard(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.schedule,
                color: kDefaultGrey,
                size: 20.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              child: Text(
                widget.title,
                style: kCaptionTextStyle.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: Text(
                selectedTimeOrInitial != null
                    ? selectedTimeOrInitial.format(context)
                    : 'Pick a time',
                style: kCaptionTextStyle.copyWith(
                  color: kDefaultGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
