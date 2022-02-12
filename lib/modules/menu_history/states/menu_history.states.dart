import 'package:flutter/material.dart';
import 'package:kubo/constants/colors_constants.dart';
import 'package:kubo/constants/menu_constants.dart';
import 'package:kubo/constants/text_styles_constants.dart';
import 'package:table_calendar/table_calendar.dart';

class MenuHistory extends StatefulWidget {
  const MenuHistory({Key? key}) : super(key: key);

  @override
  _MenuHistoryState createState() => _MenuHistoryState();
}

class _MenuHistoryState extends State<MenuHistory> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  // DateTime? _rangeStart;
  // DateTime? _rangeEnd;

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

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  // List<Event> _getEventsForRange(DateTime start, DateTime end) {
  //   // Implementation example
  //   final days = daysInRange(start, end);
  //
  //   return [
  //     for (final d in days) ..._getEventsForDay(d),
  //   ];
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // _rangeStart = null; // Important to clean those
        // _rangeEnd = null;
        // _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      // _rangeStart = start;
      // _rangeEnd = end;
      // _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      // _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuHistoryEventsList(selectedEvents: _selectedEvents),
        const SizedBox(height: 8.0),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: kBrownPrimary,
          ),
          child: TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            // rangeStartDay: _rangeStart,
            // rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            // rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Colors.white,
              ),
              weekendStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            headerStyle: const HeaderStyle(
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
            ),
            calendarStyle: const CalendarStyle(
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
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
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
    );
  }
}

class MenuHistoryEventsList extends StatelessWidget {
  const MenuHistoryEventsList({
    Key? key,
    required ValueNotifier<List<Event>> selectedEvents,
  })  : _selectedEvents = selectedEvents,
        super(key: key);

  final ValueNotifier<List<Event>> _selectedEvents;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: 28.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        color: Colors.grey.shade400,
                      ),
                      padding: const EdgeInsets.only(left: 25, right: 15),
                      child: const Center(
                        child: Text(
                          'Your event',
                          style: TextStyle(
                            fontFamily: 'Arvo',
                            color: kBlackPrimary,
                          ),
                        ),
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: kGreenPrimary,
                      radius: 14,
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.insert_invitation,
                      color: Colors.grey.shade700,
                    ),
                    Text(
                      '1/24/22',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 70,
                          child: MenuHistoryListTile(
                            event: value[index],
                            isLast: index == value.length - 1,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuHistoryListTile extends StatelessWidget {
  const MenuHistoryListTile({
    Key? key,
    required this.event,
    this.isLast = false,
  }) : super(key: key);

  final Event event;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            const Expanded(
              child: VerticalDivider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            CircleAvatar(
              backgroundColor: event.color,
              radius: 5,
            ),
            if (!isLast)
              const Expanded(
                child: VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              )
            else
              Expanded(
                child: Container(),
              ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '7:00 - 8:00 am',
              style: kCaptionTextStyle,
            ),
            Text(
              event.title,
              style: kPreSubTitleTextStyle,
            ),
          ],
        )
      ],
    );
  }
}
