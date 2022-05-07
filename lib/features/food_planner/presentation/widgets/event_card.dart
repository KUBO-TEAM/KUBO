import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';

class EventCard extends StatelessWidget {
  const EventCard({
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
                  radius: 16,
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
                    color: kGreenPrimary,
                    fontFamily: 'Montserrat Medium',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Center(
              child: Image.asset('assets/images/no_events.jpg'),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              subTitle,
              style: const TextStyle(
                color: kBlackPrimary,
                fontFamily: 'Montserrat Bold',
                fontSize: 18.0,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              caption,
              style: const TextStyle(
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
