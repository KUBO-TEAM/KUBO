import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/modules/calendar/screens/calendar.screen.dart';
import 'package:kubo/modules/camera/screens/camera.screen.dart';
import 'package:kubo/widgets/buttons/rounded.button.dart';
import 'package:kubo/widgets/cards/event.card.dart';
import 'package:kubo/widgets/cards/schedule.card.dart';
import 'package:kubo/widgets/cards/weekly_event.card.dart';
import 'package:kubo/widgets/ui/event_plan.ui.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      floatingActionButton: SpeedDial(
        backgroundColor: kGreenPrimary,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.camera,
              color: kBrownPrimary,
            ),
            label: 'Quick Recipe',
            onTap: () {
              Navigator.pushNamed(context, CameraScreen.id);
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.fact_check,
              color: kBrownPrimary,
            ),
            label: 'Ingredients',
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.storefront,
              color: kBrownPrimary,
            ),
            label: 'Recipes',
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.notifications,
              color: kBrownPrimary,
            ),
            label: 'Reminder',
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xffeeeeee),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Overview',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 40.0,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                  elevation: 0,
                  title: const Text(
                    'Timetable',
                  ),
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 16.0,
                ),
                RoundedButton(
                  elevation: 0,
                  title: const Text(
                    'Agenda',
                  ),
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 16.0,
                ),
                RoundedButton(
                  elevation: 0,
                  title: const Text(
                    'Calendar',
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, CalendarScreen.id);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const WeeklyEventCard(
              icon: Icons.trending_up,
              title: 'Weekly report',
              subTitle: 'You have no upcoming events',
              caption: 'Enjoy your weekend',
            ),
            const SizedBox(
              height: 16.0,
            ),
            const EventPlan(
              title: 'Today',
              date: 'December 28, 2021',
            ),
            const SizedBox(
              height: 16.0,
            ),
            const EventPlan(
              title: 'Tomorrow',
              date: 'December 29, 2021',
            ),
            const ScheduleCard(
              icon: Icons.restore,
              title: 'Daily Schedule',
            ),
          ],
        ),
      ),
    );
  }
}
