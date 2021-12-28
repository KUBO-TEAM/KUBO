import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/text_styles.constants.dart';

class WeeklyEventCard extends StatelessWidget {
  const WeeklyEventCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.caption,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String subTitle;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(
          minHeight: 150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: kGreenPrimary,
                  child: Icon(
                    icon,
                    size: 16.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: kGreenPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              subTitle,
              style: kSubTitleTextStyle,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              caption,
              style: kCaptionTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
