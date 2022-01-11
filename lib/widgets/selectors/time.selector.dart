import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/widgets/cards/picker.card.dart';

class TimeSelector extends StatefulWidget {
  const TimeSelector({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        TimeOfDay? timeSelected = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );

        setState(() {
          selectedTime = timeSelected;
        });
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
                selectedTime == null
                    ? 'Pick a time'
                    : selectedTime!.format(context),
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
