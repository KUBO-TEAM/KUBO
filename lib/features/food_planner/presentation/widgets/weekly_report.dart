import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/icon_title.dart';

const _title = 'Weekly report';
const _subTitle = 'You have no upcoming events';
const _caption = 'Enjoy your weekend';
const _icon = Icons.trending_up;

const _cardRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),
  ),
);

class WeeklyReport extends StatelessWidget {
  const WeeklyReport({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: _cardRadius,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(
          minHeight: 150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            IconTitle(
              icon: _icon,
              title: _title,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              _subTitle,
              style: TextStyle(
                color: kBlackPrimary,
                fontFamily: 'Montserrat Bold',
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              _caption,
              style: TextStyle(
                color: kBlackPrimary,
                fontFamily: 'Montserrat',
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
