import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/modules/calendar/states/calendar.states.dart';

class CalendarScreen extends StatelessWidget {
  static const String id = 'calendar_screen';
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kBlackPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: const Text(
          'Calendar',
          style: TextStyle(
            color: kBlackPrimary,
            fontFamily: 'Pushster',
            fontSize: 30.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: const Calendar(),
          color: kBackgroundGrey,
        ),
      ),
    );
  }
}
