import 'package:flutter/material.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';

class AssignMealTimeScreenArguments {
  AssignMealTimeScreenArguments({
    required this.recipe,
  });

  Recipe recipe;
}

class AssignMealTimeScreen extends StatelessWidget {
  static const String id = 'assign_meal_time_screen';

  const AssignMealTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as AssignMealTimeScreenArguments;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        title: const Text(
          'Assign Meal Time',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Pushster',
            fontSize: 30.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            //
            child: Image.network(
              args.recipe.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCC000000),
                  Color(0x00000000),
                  Color(0x00000000),
                  Color(0xCC000000),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
