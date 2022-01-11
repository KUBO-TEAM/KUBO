import 'package:flutter/material.dart';
import 'package:kubo/core/walk_through/welcome_screen.dart';
import 'package:kubo/modules/camera/models/camera.model.dart';
import 'package:kubo/modules/camera/screens/camera.screen.dart';
import 'package:kubo/modules/camera/screens/captured.screen.dart';
import 'package:kubo/modules/calendar/screens/calendar.screen.dart';
import 'package:kubo/modules/home/screens/home.screen.dart';
import 'package:kubo/modules/meal_plan/screens/assign_meal_time.screen.dart';
import 'package:kubo/modules/meal_plan/screens/select_ingredients.screen.dart';
import 'package:kubo/modules/meal_plan/screens/create_meal_plan.screen.dart';
import 'package:kubo/modules/timetable/screens/timetable.screen.dart';
import 'package:kubo/modules/agenda/screens/agenda.screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const Kubo());

class Kubo extends StatelessWidget {
  const Kubo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CameraModel(),
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          CameraScreen.id: (context) => const CameraScreen(),
          CalendarScreen.id: (context) => const CalendarScreen(),
          CapturedScreen.id: (context) => const CapturedScreen(),
          TimeTableScreen.id: (context) => const TimeTableScreen(),
          AgendaScreen.id: (context) => const AgendaScreen(),
          SelectIngredientsScreen.id: (context) =>
              const SelectIngredientsScreen(),
          CreateMealPlanScreen.id: (context) => const CreateMealPlanScreen(),
          AssignMealTimeScreen.id: (context) => const AssignMealTimeScreen(),
        },
      ),
    );
  }
}
