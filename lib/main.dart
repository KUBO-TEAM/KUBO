import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kubo/core/models/schedule.hive.dart';
import 'package:kubo/core/walk_through/splash_screen.dart';
import 'package:kubo/core/walk_through/welcome_screen.dart';
import 'package:kubo/modules/agenda/models/agenda.model.dart';
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
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(ScheduleHiveAdapter());
  runApp(const Kubo());
}

class Kubo extends StatelessWidget {
  const Kubo({Key? key}) : super(key: key);

  Future<String> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      // await prefs.setBool('seen', false);
      return SplashScreen.id;
    } else {
      return WelcomeScreen.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: checkFirstSeen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(color: Colors.white,);
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => CameraModel(),
              ),
              ChangeNotifierProvider(
                create: (_) => AgendaList(),
              )
            ],
            child: MaterialApp(
              initialRoute: snapshot.data,
              routes: {
                SplashScreen.id: (context) => const SplashScreen(),
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
    );
  }
}
