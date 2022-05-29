import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/menu_history/menu_history_bloc.dart';
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
            style: TextStyle(
              fontFamily: 'Montserrat Medium',
              fontSize: 14.0,
            ),
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
            style: TextStyle(
              fontFamily: 'Montserrat Medium',
              fontSize: 14.0,
            ),
          ),
          onPressed: () {
            BlocProvider.of<MenuHistoryBloc>(context).add(
              MenuHistoryRecipeScheduleFetched(),
            );
            Navigator.pushNamed(context, MenuHistoryPage.id);
          },
        ),
        const SizedBox(
          width: 8.0,
        ),
        RoundedButton(
          elevation: 0,
          title: const Text(
            'Agenda',
            style: TextStyle(
              fontFamily: 'Montserrat Medium',
              fontSize: 14.0,
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, AgendaPage.id),
        ),
      ],
    );
  }
}
