import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/reminders_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/select_ingredients_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';

class FloatingHomeButton extends StatelessWidget {
  const FloatingHomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: kGreenPrimary,
      animatedIcon: AnimatedIcons.menu_close,
      animationSpeed: 800,
      children: [
        SpeedDialChild(
            child: const Icon(
              Icons.camera,
              color: kBrownPrimary,
            ),
            label: 'Quick Recipe',
            onTap: () => Navigator.pushNamed(context, CameraPage.id)),
        SpeedDialChild(
          child: const Icon(
            Icons.fact_check,
            color: kBrownPrimary,
          ),
          label: 'Ingredients',
        ),
        SpeedDialChild(
            child: const Icon(
              Icons.storefront,
              color: kBrownPrimary,
            ),
            label: 'Recipes',
            onTap: () => Navigator.pushNamed(context, RecipePage.id)),
        SpeedDialChild(
            child: const Icon(
              Icons.notifications,
              color: kBrownPrimary,
            ),
            label: 'Reminder',
            onTap: () => Navigator.pushNamed(context, ReminderPage.id)),
      ],
    );
  }
}

class FloatingMenuButton extends StatelessWidget {
  const FloatingMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: kGreenPrimary,
      animatedIcon: AnimatedIcons.menu_close,
      animationSpeed: 800,
      children: [
        SpeedDialChild(
          child: const Icon(
            Icons.menu_book,
            color: kBrownPrimary,
          ),
          label: 'Create meal plan',
          onTap: () {
            Navigator.pushNamed(context, SelectIngredientsPage.id);
          },
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.fact_check,
            color: kBrownPrimary,
          ),
          label: 'Ingredients',
        ),
      ],
    );
  }
}
