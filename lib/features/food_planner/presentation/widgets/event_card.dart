import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
    required this.recipeSchedule,
    required this.eventTitle,
    required this.eventIcon,
  }) : super(key: key);

  final RecipeSchedule? recipeSchedule;

  final String eventTitle;
  final IconData eventIcon;

  @override
  Widget build(BuildContext context) {
    final finalRcipeSchedule = recipeSchedule;
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
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
        ),
        constraints: const BoxConstraints(
          minHeight: 150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 16.0,
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: kGreenPrimary,
                  child: Icon(
                    eventIcon,
                    size: 16.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  eventTitle,
                  style: const TextStyle(
                    color: kGreenPrimary,
                    fontFamily: 'Montserrat Medium',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            if (finalRcipeSchedule == null)
              Center(
                child: Image.asset('assets/images/no_events.jpg'),
              ),
            if (finalRcipeSchedule != null)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      finalRcipeSchedule.recipe.displayPhoto,
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                finalRcipeSchedule != null
                    ? finalRcipeSchedule.recipe.name
                    : 'No schedule for today',
                style: const TextStyle(
                  color: kBlackPrimary,
                  fontFamily: 'Montserrat Bold',
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                finalRcipeSchedule != null
                    ? '${DateFormat.jm('en_US').format(finalRcipeSchedule.start)} - ${DateFormat.jm('en_US').format(finalRcipeSchedule.end)} '
                    : 'You can add new events with the button in the bottom right corner',
                style: const TextStyle(
                  color: kBlackPrimary,
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
