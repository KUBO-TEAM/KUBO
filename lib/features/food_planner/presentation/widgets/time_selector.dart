import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/text_styles_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/picker_card.dart';

class TimeSelector extends StatefulWidget {
  const TimeSelector({
    Key? key,
    required this.title,
    required this.onTimePicked,
    this.initialTimeOfDay,
  }) : super(key: key);

  final String title;
  final Function(TimeOfDay?) onTimePicked;
  final TimeOfDay? initialTimeOfDay;

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();

    if (widget.initialTimeOfDay != null) {
      setState(() {
        selectedTime = widget.initialTimeOfDay;
      });

      widget.onTimePicked(widget.initialTimeOfDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final initialTimeOfDay = widget.initialTimeOfDay;

        TimeOfDay? timeSelected = await showTimePicker(
          initialTime: initialTimeOfDay ?? TimeOfDay.now(),
          context: context,
        );

        if (timeSelected != null) {
          setState(() {
            selectedTime = timeSelected;
          });

          widget.onTimePicked(timeSelected);
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
                selectedTime != null
                    ? selectedTime!.format(context)
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
