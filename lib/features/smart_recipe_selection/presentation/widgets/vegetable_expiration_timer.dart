import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:kubo/core/constants/date_time_constants.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';

class VegetableExpirationTimer extends StatelessWidget {
  const VegetableExpirationTimer({
    Key? key,
    required this.predictedImage,
  }) : super(key: key);

  final PredictedImage predictedImage;

  String addLeadingZero(int? num) {
    if (num == null) return '0';
    return num < 10 ? '0$num' : num.toString();
  }

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      endTime: predictedImage.predictedAt
          .add(kGlobalVegetablesExpirationDurationDate)
          .millisecondsSinceEpoch,
      widgetBuilder: (_, time) {
        if (time == null) {
          return Text(
            predictedImage.categories.length > 1
                ? 'Warning: These vegetables surpassed the date recommended for cooking.'
                : 'Warning: This vegetable surpassed the date recommended for cooking.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  addLeadingZero(time.days),
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Days',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              ':',
              style: TextStyle(
                fontSize: 26.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                Text(
                  addLeadingZero(time.hours),
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Hours',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              ':',
              style: TextStyle(
                fontSize: 26.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                Text(
                  addLeadingZero(time.min),
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Minutes',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              ':',
              style: TextStyle(
                fontSize: 26.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                Text(
                  addLeadingZero(time.sec),
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Seconds',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
