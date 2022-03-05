import 'package:flutter/material.dart';
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
          onPressed: () => Navigator.pushNamed(context, MenuPage.id),
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
