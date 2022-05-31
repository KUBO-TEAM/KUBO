import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/menu_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart';
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
    color: kGreenPrimary,
    shape: BoxShape.circle,
  ),
  todayDecoration: BoxDecoration(
    color: kGreenPrimary,
    shape: BoxShape.circle,
  ),
  markerDecoration: BoxDecoration(
    color: kGreenPrimary,
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
  late final ValueNotifier<List<RecipeSchedule>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now().add(const Duration(days: -1));
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).add(
      CreateRecipeScheduleDialogInitializeState(),
    );

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(
      _getListOfRecipeScheduleForDay(
        day: _selectedDay!,
        state: BlocProvider.of<MenuHistoryBloc>(context).state,
      ),
    );
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KuboAppBar(
        'Menu History',
        onBackButtonPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: BlocBuilder<MenuHistoryBloc, MenuHistoryState>(
            builder: (context, state) {
              return Column(
                children: [
                  MenuHistoryEventsList(
                    selectedEvents: _selectedEvents,
                    selectedDay: _selectedDay,
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    decoration: _calendarContainerRadius,
                    child: TableCalendar<RecipeSchedule>(
                      currentDay: DateTime.now().add(const Duration(days: -1)),
                      firstDay: kFirstDay,
                      lastDay: DateTime.now().add(const Duration(days: -1)),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      calendarFormat: _calendarFormat,
                      eventLoader: (DateTime day) {
                        return _getListOfRecipeScheduleForDay(
                          day: day,
                          state: state,
                        );
                      },
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      daysOfWeekStyle: _calendarDaysOfWeekStyle,
                      headerStyle: _calendarHeaderStyle,
                      calendarStyle: _calendarStyle,
                      onDaySelected: (
                        DateTime selectedDay,
                        DateTime focusedDay,
                      ) {
                        _onDaySelected(
                          selectedDay: selectedDay,
                          focusedDay: focusedDay,
                          state: state,
                        );
                      },
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
                      calendarBuilders: CalendarBuilders(
                        singleMarkerBuilder: (context, date, event) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: lightenColor(
                                  event.color ?? kGreenPrimary, .2),
                            ),
                            width: 7.0,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<RecipeSchedule> _getListOfRecipeScheduleForDay({
    required MenuHistoryState state,
    required DateTime day,
  }) {
    if (state is MenuHistorySuccess) {
      final result = state.recipeScheduleLinkedHashmap[day];
      if (result != null) {
        return result;
      }
    }

    return [];
  }

  void _onDaySelected({
    required DateTime selectedDay,
    required DateTime focusedDay,
    required MenuHistoryState state,
  }) {
    if (state is MenuHistorySuccess) {
      if (!isSameDay(_selectedDay, selectedDay)) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });

        _selectedEvents.value = _getListOfRecipeScheduleForDay(
          day: selectedDay,
          state: state,
        );
      }
    }
  }

  Color lightenColor(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
