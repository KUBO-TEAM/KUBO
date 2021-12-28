import 'package:flutter/material.dart';
import 'package:kubo/constants/text_styles.constants.dart';
import 'package:kubo/widgets/cards/event.card.dart';

class EventPlan extends StatelessWidget {
  const EventPlan({
    Key? key,
    required this.title,
    required this.date,
  }) : super(key: key);

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: kTitleTextStyle,
              ),
              Text(
                date,
                style: kCaptionTextStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          const EventCard(
            icon: Icons.pending_actions,
            title: 'Pending events',
            subTitle: 'There are no events',
            caption:
                'You can add new events with the button in the \nbottom right corner',
          )
        ],
      ),
    );
  }
}
