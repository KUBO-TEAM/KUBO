import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';
import 'package:kubo/core/walk_through/splash_screen.dart';
import 'package:kubo/widgets/buttons/rounded.button.dart';
import 'package:kubo/widgets/clippers/welcome.clipper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _storeWelcomeInfo() async {
    bool _seen = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', _seen);
  }

  final List<AssetImage> _carouselImages = [
    const AssetImage(
      "assets/images/carousel/welcome_screen_bg.png",
    ),
    const AssetImage(
      "assets/images/carousel/welcome_screen_bg_2.png",
    ),
    const AssetImage(
      "assets/images/carousel/welcome_screen_bg_3.jpg",
    ),
    const AssetImage(
      "assets/images/carousel/welcome_screen_bg_4.jpg",
    ),
    const AssetImage(
      "assets/images/carousel/welcome_screen_bg_5.jpg",
    ),
    const AssetImage(
      "assets/images/carousel/welcome_screen_bg_6.jpg",
    ),
    const AssetImage(
      "assets/images/carousel/welcome_screen_bg_7.jpg",
    ),
    const AssetImage(
      "assets/images/carousel/welcome_screen_bg_8.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double kScreenHeight = MediaQuery.of(context).size.height;
    double kScreenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1,
              autoPlay: true,
            ),
            items: [0, 1, 2, 3, 4, 5, 6, 7].map(
              (i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _carouselImages[i],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          ),
          const WelcomeClipper(),
          Positioned(
            top: kScreenHeight * 0.55,
            left: 12,
            child: Container(
              height: 250.0,
              width: kScreenWidth,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arvo Bold',
                      color: Color(0xff285E01),
                    ),
                  ),
                  const Text(
                    'KUBO',
                    style: TextStyle(
                      fontSize: 50,
                      color: kBlackPrimary,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'JosefinSans Bold',
                    ),
                  ),
                  const Text(
                    'Giving you a strategic meal plan with the \ningredients at your disposal',
                    style: TextStyle(
                      fontSize: 16,
                      color: kBlackPrimary,
                      fontFamily: 'Arvo',
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 45.0,
                        vertical: 20.0,
                      ),
                      child: RoundedButton(
                        onPressed: () {
                          _storeWelcomeInfo();
                          Navigator.popAndPushNamed(context, SplashScreen.id);
                        },
                        title: const Text(
                          'Try Now',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

