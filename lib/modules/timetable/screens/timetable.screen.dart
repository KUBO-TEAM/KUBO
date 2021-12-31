import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimeTableScreen extends StatelessWidget {
  static const String id = 'timetable_screen';
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: kGreenPrimary,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SfCalendar(
          todayHighlightColor: Colors.green,
          headerStyle: const CalendarHeaderStyle(
            backgroundColor: kBrownPrimary,
            textStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Lora',
              fontSize: 24,
            ),
          ),
          viewHeaderStyle: const ViewHeaderStyle(
            backgroundColor: kBrownPrimary,
            dateTextStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Arvo',
            ),
            dayTextStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Arvo',
            ),
          ),
          view: CalendarView.week,
          weekNumberStyle: const WeekNumberStyle(
              textStyle: TextStyle(
            fontFamily: 'Arvo',
          )),
          firstDayOfWeek: 1,
        ),
      ),
    );
  }
}
