import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/constants/string.constants.dart';
import 'package:kubo/core/walk_through/welcome_screen.dart';
import 'package:kubo/modules/home/screens/home.screen.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loading();
  }

  _loading() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    var box = await Hive.openBox(kUIBox);

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: kScreenHeight * .5,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  scale: 2,
                  image: AssetImage(
                    "assets/images/logo.png",
                  ),
                  // fit: BoxFit.none,
                ),
              ),
            ),
            const CircularProgressIndicator(
              color: kGreenPrimary,
            ),
          ],
        ));
  }
}
