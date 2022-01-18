import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/string.constants.dart';
import 'package:kubo/core/walk_through/welcome_screen.dart';
import 'package:kubo/modules/home/screens/home.screen.dart';
import 'package:hive/hive.dart';
import 'package:kubo/modules/menu/models/menu.notifier.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 2300),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    _loading();
    Future.microtask(
      () => Provider.of<MenuNotifier>(context, listen: false).fetchSchedule(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _loading() async {
    var box = await Hive.openBox(kUIBox);
    await Future.delayed(const Duration(milliseconds: 4000), () {});
    bool? isWelcomeScreenSeen = box.get('is_welcome_screen_seen');

    // box.deleteAll(box.keys);

    if (isWelcomeScreenSeen == null || isWelcomeScreenSeen == false) {
      Navigator.popAndPushNamed(context, WelcomeScreen.id);
    } else {
      Navigator.popAndPushNamed(context, HomeScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    double kScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            "assets/images/logo.png",
            height: kScreenHeight * .4,
          ),
        ),
        height: kScreenHeight,
      ),
    );
  }
}
