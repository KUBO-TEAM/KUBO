import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/pages/agenda_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/menu_history_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/menu_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/rounded_button.dart';

class PlannerButtons extends StatelessWidget {
  const PlannerButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedButton(
          elevation: 0,
          title: const Text(
            'Menu',
          ),
          onPressed: () {
            Navigator.pushNamed(context, MenuPage.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: kBrownPrimary,
                content: Row(
                  children: const [
                    SizedBox(
                      child: CircularProgressIndicator(),
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Checking for recipe updates',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(
          width: 8.0,
        ),
        RoundedButton(
          elevation: 0,
          title: const Text(
            'Menu History',
          ),
          onPressed: () => Navigator.pushNamed(context, MenuHistoryPage.id),
        ),
        const SizedBox(
          width: 8.0,
        ),
        RoundedButton(
          elevation: 0,
          title: const Text(
            'Agenda',
          ),
          onPressed: () => Navigator.pushNamed(context, AgendaPage.id),
        ),
      ],
    );
  }
}
