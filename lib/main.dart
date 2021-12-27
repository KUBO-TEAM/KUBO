import 'package:flutter/material.dart';
import 'package:kubo/core/walk_through/welcome_screen.dart';
import 'package:kubo/modules/camera/models/camera.model.dart';
import 'package:kubo/modules/camera/screens/camera.screen.dart';
import 'package:kubo/modules/camera/screens/captured.screen.dart';
import 'package:kubo/modules/timetable/screens/timetable.screen.dart';
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
          CameraScreen.id: (context) => const CameraScreen(),
          TimeTableScreen.id: (context) => const TimeTableScreen(),
          CapturedScreen.id: (context) => const CapturedScreen(),
        },
      ),
    );
  }
}
