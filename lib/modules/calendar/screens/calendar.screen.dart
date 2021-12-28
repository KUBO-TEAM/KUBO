import 'package:flutter/material.dart';
import 'package:kubo/modules/calendar/states/calendar.states.dart';

class CalendarScreen extends StatelessWidget {
  static const String id = 'calendar_screen';
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Calendar(),
      ),
    );
  }
}
