import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/sizes.constants.dart';
import 'package:kubo/modules/agenda/screens/agenda.screen.dart';
import 'package:kubo/modules/menu_history/screens/menu_history.screen.dart';
import 'package:kubo/modules/camera/screens/camera.screen.dart';
import 'package:kubo/modules/menu/screens/menu.screen.dart';
import 'package:kubo/widgets/buttons/rounded.button.dart';
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
      floatingActionButton: const FloatingMenuButton(),
      appBar: PreferredSize(
        preferredSize: kAppBarPrefferedSize,
        child: AppBar(
          backgroundColor: kBackgroundGrey,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: const Text(
            'Overview',
            style: TextStyle(
              color: kBlackPrimary,
              fontFamily: 'Pushster',
              fontSize: 30.0,
            ),
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
          children: const [
            SchedulesButton(),
            SizedBox(
              height: 5.0,
            ),
            WeeklyEventCard(
              icon: Icons.trending_up,
              title: 'Weekly report',
              subTitle: 'You have no upcoming events',
              caption: 'Enjoy your weekend',
            ),
            SizedBox(
              height: 10.0,
            ),
            EventPlan(
              title: 'Today',
              date: 'December 28, 2021',
            ),
            SizedBox(
              height: 10.0,
            ),
            EventPlan(
              title: 'Tomorrow',
              date: 'December 29, 2021',
            ),
            ScheduleCard(
              icon: Icons.restore,
              title: 'Daily Schedule',
            ),
          ],
        ),
      ),
    );
  }
}

class SchedulesButton extends StatelessWidget {
  const SchedulesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedButton(
          elevation: 0,
          title: const Text(
            'Menu',
          ),
          onPressed: () {
            Navigator.pushNamed(context, MenuScreen.id);
          },
        ),
        const SizedBox(
          width: 16.0,
        ),
        RoundedButton(
          elevation: 0,
          title: const Text(
            'Agenda',
          ),
          onPressed: () {
            Navigator.pushNamed(context, AgendaScreen.id);
          },
        ),
        const SizedBox(
          width: 16.0,
        ),
        RoundedButton(
          elevation: 0,
          title: const Text(
            'Menu History',
          ),
          onPressed: () {
            Navigator.pushNamed(context, MenuHistoryScreen.id);
          },
        ),
      ],
    );
  }
}

class FloatingMenuButton extends StatelessWidget {
  const FloatingMenuButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: kGreenPrimary,
      animatedIcon: AnimatedIcons.menu_close,
      animationSpeed: 800,
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
    );
  }
}
