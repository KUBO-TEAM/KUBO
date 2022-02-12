import 'package:flutter/material.dart';
import 'package:kubo/constants/colors_constants.dart';
import 'package:kubo/constants/text_styles_constants.dart';
import 'package:kubo/widgets/cards/picker.card.dart';

class TimeSelector extends StatelessWidget {
  const TimeSelector({
    Key? key,
    required this.title,
    required this.onTimePicked,
    this.initialTime,
  }) : super(key: key);

  final String title;
  final Function(TimeOfDay?) onTimePicked;
  final TimeOfDay? initialTime;

  Text _timeStatus(BuildContext context) {
    if (initialTime != null) {
      return Text(
        initialTime!.format(context),
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
        if (initialTime != null) {
          TimeOfDay? timeSelected = await showTimePicker(
            initialTime: initialTime!,
            context: context,
          );

          onTimePicked(timeSelected);
        } else {
          TimeOfDay? timeSelected = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );

          onTimePicked(timeSelected);
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
                title,
                style: kCaptionTextStyle.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: _timeStatus(context),
            )
          ],
        ),
      ),
    );
  }
}
