import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

const kCalendarHeaderStyle = CalendarHeaderStyle(
  backgroundColor: kBrownPrimary,
  textAlign: TextAlign.center,
  textStyle: TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat Bold',
    fontSize: 20.0,
  ),
);

const kCalendarViewHeaderStyle = ViewHeaderStyle(
  backgroundColor: kBrownPrimary,
  dayTextStyle: TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat Medium',
    fontSize: 16.0,
  ),
  dateTextStyle: TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
    fontSize: 14.0,
  ),
);

const kCalendarWeekNumberStyle = WeekNumberStyle(
  textStyle: TextStyle(
    color: Colors.white,
    fontFamily: 'Montserrat',
  ),
);

const kCalendarTimeSlotViewSettings = TimeSlotViewSettings(
  timeIntervalHeight: 70,
);
