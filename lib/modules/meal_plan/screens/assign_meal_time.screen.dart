import 'package:flutter/material.dart';
import 'package:kubo/constants/colors.constants.dart';

class AssignMealTimeScreen extends StatelessWidget {
  static const String id = 'assign_meal_time_screen';

  const AssignMealTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: kBlackPrimary, //change your color here
        ),
        elevation: 0,
        title: const Text(
          'Assign Meal Time',
          style: TextStyle(
            color: kBlackPrimary,
            fontFamily: 'Pushster',
            fontSize: 30.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
