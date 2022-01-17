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
import 'package:kubo/modules/menu_history/screens/menu_history.screen.dart';
import 'package:kubo/modules/home/screens/home.screen.dart';
import 'package:kubo/modules/meal_plan/screens/assign_meal_time.screen.dart';
import 'package:kubo/modules/meal_plan/screens/select_ingredients.screen.dart';
import 'package:kubo/modules/meal_plan/screens/create_meal_plan.screen.dart';
import 'package:kubo/modules/menu/screens/menu.screen.dart';
import 'package:kubo/modules/agenda/screens/agenda.screen.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

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

  @override
  Widget build(BuildContext context) {
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
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          CameraScreen.id: (context) => const CameraScreen(),
          MenuHistoryScreen.id: (context) => const MenuHistoryScreen(),
          CapturedScreen.id: (context) => const CapturedScreen(),
          MenuScreen.id: (context) => const MenuScreen(),
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
