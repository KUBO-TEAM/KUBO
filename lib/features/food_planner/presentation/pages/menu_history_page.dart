import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/menu_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/kubo_app_bars.dart';
import 'package:kubo/features/food_planner/presentation/widgets/menu_history_event_list.dart';
import 'package:table_calendar/table_calendar.dart';

const _calendarHeaderStyle = HeaderStyle(
  formatButtonDecoration: BoxDecoration(
    border: Border.fromBorderSide(BorderSide(color: Colors.white)),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  leftChevronIcon: Icon(
    Icons.chevron_left,
    color: Colors.white,
  ),
  rightChevronIcon: Icon(
    Icons.chevron_right,
    color: Colors.white,
  ),
  titleTextStyle: TextStyle(
    color: Colors.white,
  ),
  formatButtonTextStyle: TextStyle(
    color: Colors.white,
  ),
);

const _calendarStyle = CalendarStyle(
  selectedDecoration: BoxDecoration(
    color: Colors.green,
    shape: BoxShape.circle,
  ),
  todayDecoration: BoxDecoration(
    color: kGreenPrimary,
    shape: BoxShape.circle,
  ),
  markerDecoration: BoxDecoration(
    color: Colors.green,
    shape: BoxShape.circle,
  ),
  weekendTextStyle: TextStyle(
    color: Colors.white,
  ),
  defaultTextStyle: TextStyle(
    color: Colors.white,
  ),
  // Use `CalendarStyle` to customize the UI
  outsideDaysVisible: false,
);

const _calendarContainerRadius = BoxDecoration(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40),
    topRight: Radius.circular(40),
  ),
  color: kBrownPrimary,
);

const _calendarDaysOfWeekStyle = DaysOfWeekStyle(
  weekdayStyle: TextStyle(
    color: Colors.white,
  ),
  weekendStyle: TextStyle(
    color: Colors.white,
  ),
);

class MenuHistoryPage extends StatefulWidget {
  static const String id = 'menu_history_page';
  const MenuHistoryPage({Key? key}) : super(key: key);

  @override
  State<MenuHistoryPage> createState() => _MenuHistoryPageState();
}

class _MenuHistoryPageState extends State<MenuHistoryPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KuboAppBar('Menu History'),
      body: SafeArea(
        child: Container(
          color: kBackgroundGrey,
          child: Column(
            children: [
              MenuHistoryEventsList(selectedEvents: _selectedEvents),
              const SizedBox(height: 8.0),
              Container(
                decoration: _calendarContainerRadius,
                child: TableCalendar<Event>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: _calendarFormat,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekStyle: _calendarDaysOfWeekStyle,
                  headerStyle: _calendarHeaderStyle,
                  calendarStyle: _calendarStyle,
                  onDaySelected: _onDaySelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }
}
