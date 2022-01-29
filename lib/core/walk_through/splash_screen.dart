import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kubo/constants/string.constants.dart';
import 'package:kubo/core/walk_through/welcome_screen.dart';
import 'package:kubo/modules/home/screens/home.screen.dart';
import 'package:kubo/modules/menu/bloc/menu_cubit.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _loading();
    Future.microtask(
      () => BlocProvider.of<MenuCubit>(context).fetchAppointments(),
    );
  }

  _loading() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    setState(() {
      _visible = !_visible;
    });
    await Future.delayed(const Duration(milliseconds: 2500), () {});

    var box = await Hive.openBox(kUIBox);

    bool? isWelcomeScreenSeen = box.get('is_welcome_screen_seen');

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
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 2500),
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
