import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/sizes.constants.dart';
import 'package:kubo/constants/string.constants.dart';
import 'package:kubo/core/models/schedule.hive.dart';
import 'package:kubo/modules/meal_plan/screens/select_ingredients.screen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MenuScreen extends StatefulWidget {
  static const String id = 'menu_screen';
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Appointment> appointments = [];
  Box<dynamic>? scheduleBox;

  Future<void> _fetchSchedules() async {
    scheduleBox = await Hive.openBox(kScheduleBox);

    if (scheduleBox!.isEmpty == false) {
      for (var element in scheduleBox!.values) {
        appointments.add(
          Appointment(
            startTime: element.startTime,
            endTime: element.endTime,
            subject: element.recipeName,
            color: element.color,
          ),
        );
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        backgroundColor: kGreenPrimary,
        animatedIcon: AnimatedIcons.menu_close,
        animationSpeed: 800,
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.menu_book,
              color: kBrownPrimary,
            ),
            label: 'Create meal plan',
            onTap: () {
              Navigator.pushNamed(context, SelectIngredientsScreen.id);
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.fact_check,
              color: kBrownPrimary,
            ),
            label: 'Ingredients',
          ),
        ],
      ),
      appBar: PreferredSize(
        preferredSize: kAppBarPrefferedSize,
        child: AppBar(
          backgroundColor: kBackgroundGrey,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: kBlackPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: const Text(
            'Menu',
            style: TextStyle(
              color: kBlackPrimary,
              fontFamily: 'Pushster',
              fontSize: 30.0,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SfCalendar(
          todayHighlightColor: Colors.green,
          dataSource: MealTimeDataSource(appointments),
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

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];

  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
    startTime: startTime,
    endTime: endTime,
    subject: 'Conference',
    color: Colors.blue,
  ));

  return meetings;
}

class MealTimeDataSource extends CalendarDataSource {
  MealTimeDataSource(List<Appointment>? source) {
    appointments = source;
  }
}
