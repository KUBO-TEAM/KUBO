import 'package:flutter/material.dart';
import 'package:kubo/modules/home/screens/home.screen.dart';
import 'package:kubo/widgets/buttons/rounded.button.dart';
import 'package:kubo/widgets/clippers/welcome.clipper.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double kScreenHeight = MediaQuery.of(context).size.height;
    double kScreenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_screen_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
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
                      color: Color(0xff285E01),
                    ),
                  ),
                  const Text(
                    'KUBO',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Giving you a strategic meal plan with the \ningredients at your disposal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 45.0,
                        vertical: 20.0,
                      ),
                      child: RoundedButton(
                        onPressed: () async {
                          Navigator.pushNamed(
                            context,
                            HomeScreen.id,
                            arguments: {},
                          );
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
