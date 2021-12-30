import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimeTableScreen extends StatelessWidget {
  static const String id = 'timetable_screen';
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.week,
          firstDayOfWeek: 1,
        ),
      ),
    );
  }
}
