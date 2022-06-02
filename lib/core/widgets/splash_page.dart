import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/core/constants/string_constants.dart';
import 'package:kubo/core/widgets/welcome_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/home_page.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'splash_screen';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _loading();
  }

  _loading() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    setState(() {
      _visible = !_visible;
    });
    await Future.delayed(const Duration(milliseconds: 1500), () {});

    var box = await Hive.openBox(kUIBox);

    bool? isWelcomePageSeen = box.get('is_welcome_page_seen');

    if (isWelcomePageSeen == null || isWelcomePageSeen == false) {
      Navigator.popAndPushNamed(context, WelcomePage.id);
    } else {
      Navigator.popAndPushNamed(context, HomePage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    double kScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
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
            Positioned(
              bottom: 0,
              child: SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: RichText(
                  text: TextSpan(
                    text: 'Visit our website at ',
                    style: const TextStyle(
                      fontSize: 17.0,
                      color: kBlackPrimary,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' https://kuboph.dev',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kGreenPrimary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString('https://kuboph.dev');
                          },
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
