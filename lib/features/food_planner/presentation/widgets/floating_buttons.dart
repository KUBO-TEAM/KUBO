import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipes_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/reminders_page.dart';
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
      children: [
        SpeedDialChild(
            child: const Icon(
              Icons.camera,
              color: kBrownPrimary,
            ),
            label: 'Add Ingredient',
            onTap: () => Navigator.pushNamed(context, CameraPage.id)),
        SpeedDialChild(
          child: const Icon(
            Icons.storefront,
            color: kBrownPrimary,
          ),
          label: 'Recipes',
          onTap: () {
            BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).add(
              CreateRecipeScheduleDialogInitializeState(),
            );

            Navigator.pushNamed(
              context,
              RecipesPage.id,
              arguments: RecipesPageArguments(),
            );
          },
        ),
        SpeedDialChild(
            child: const Icon(
              Icons.notifications,
              color: kBrownPrimary,
            ),
            label: 'Reminders',
            onTap: () => Navigator.pushNamed(context, ReminderPage.id)),
      ],
    );
  }
}
