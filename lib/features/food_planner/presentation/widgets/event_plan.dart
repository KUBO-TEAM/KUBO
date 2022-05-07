import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/event_card.dart';

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
                style: const TextStyle(
                  color: kBlackPrimary,
                  fontFamily: 'Montserrat Bold',
                  fontSize: 20.0,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: kBlackPrimary,
                  fontFamily: 'Montserrat',
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          const EventCard(
            icon: Icons.pending_actions,
            title: 'Pending events',
            subTitle: 'There are no events',
            caption:
                'You can add new events with the button in the bottom right corner',
          )
        ],
      ),
    );
  }
}
