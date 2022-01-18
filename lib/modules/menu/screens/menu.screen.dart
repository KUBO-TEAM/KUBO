import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/sizes.constants.dart';
import 'package:kubo/constants/string.constants.dart';
import 'package:kubo/modules/meal_plan/screens/create_meal_plan.screen.dart';
import 'package:kubo/modules/meal_plan/screens/select_ingredients.screen.dart';
import 'package:kubo/modules/menu/models/menu.notifier.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MenuScreen extends StatelessWidget {
  static const String id = 'menu_screen';
  const MenuScreen({Key? key}) : super(key: key);

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
        child: Consumer<MenuNotifier>(builder: (context, menuNotifier, child) {
          return SfCalendar(
            todayHighlightColor: Colors.green,
            dataSource: MealTimeDataSource(menuNotifier.appointments),
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
            onTap: (CalendarTapDetails details) {
              dynamic appointment = details.appointments;
              DateTime date = details.date!;
              CalendarElement element = details.targetElement;
              Navigator.pushNamed(context, SelectIngredientsScreen.id);
            },
          );
        }),
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
