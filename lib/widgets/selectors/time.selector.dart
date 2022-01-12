import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/widgets/cards/picker.card.dart';

class TimeSelector extends StatefulWidget {
  const TimeSelector({
    Key? key,
    required this.title,
    required this.onTimePicked,
    this.initialTime,
  }) : super(key: key);

  final String title;
  final Function(TimeOfDay?) onTimePicked;
  final TimeOfDay? initialTime;

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  TimeOfDay? selectedTime;

  Text _timeStatus() {
    if (selectedTime != null) {
      return Text(
        selectedTime!.format(context),
        style: kCaptionTextStyle.copyWith(
          color: kDefaultGrey,
        ),
      );
    } else if (widget.initialTime != null) {
      return Text(
        widget.initialTime!.format(context),
        style: kCaptionTextStyle.copyWith(
          color: kDefaultGrey,
        ),
      );
    }

    return Text(
      'Pick a time',
      style: kCaptionTextStyle.copyWith(
        color: kDefaultGrey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.initialTime != null) {
          TimeOfDay? timeSelected = await showTimePicker(
            initialTime: widget.initialTime!,
            context: context,
          );

          widget.onTimePicked(timeSelected);

          setState(() {
            selectedTime = timeSelected;
          });
        } else {
          TimeOfDay? timeSelected = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );

          widget.onTimePicked(timeSelected);

          setState(() {
            selectedTime = timeSelected;
          });
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
              child: _timeStatus(),
            )
          ],
        ),
      ),
    );
  }
}
