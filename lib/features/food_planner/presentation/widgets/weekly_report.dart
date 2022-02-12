import 'package:flutter/material.dart';
import 'package:kubo/constants/colors_constants.dart';
import 'package:kubo/constants/text_styles_constants.dart';

const _title = 'Weekly report';
const _subTitle = 'You have no upcoming events';
const _caption = 'Enjoy your weekend';

const _icon = Icon(
  Icons.trending_up,
  size: 16.0,
  color: Colors.white,
);

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
            _TopBar(),
            SizedBox(
              height: 10.0,
            ),
            Text(
              _subTitle,
              style: kSubTitleTextStyle,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              _caption,
              style: kCaptionTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        CircleAvatar(
          radius: 15,
          backgroundColor: kGreenPrimary,
          child: _icon,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          _title,
          style: TextStyle(
            fontSize: 16.0,
            color: kGreenPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
