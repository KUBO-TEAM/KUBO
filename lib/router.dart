import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/temp/recipe.dart';
import 'package:kubo/core/walk_through/splash_page.dart';
import 'package:kubo/core/walk_through/welcome_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/agenda_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/assign_meal_time_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/create_meal_plan_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/home_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/menu_history_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/menu_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_steps_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/reminders_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/select_ingredients_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/captured_page.dart';

@lazySingleton
class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashPage.id:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
      case WelcomePage.id:
        return MaterialPageRoute(
          builder: (_) => const WelcomePage(),
        );

      case HomePage.id:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case CameraPage.id:
        return MaterialPageRoute(
          builder: (_) => const CameraPage(),
        );
      case MenuHistoryPage.id:
        return MaterialPageRoute(
          builder: (_) => const MenuHistoryPage(),
        );
      case CapturedPage.id:
        final arguments = routeSettings.arguments as CapturedPageArguments;

        return MaterialPageRoute(
          builder: (_) => CapturedPage(arguments: arguments),
        );
      case MenuPage.id:
        return MaterialPageRoute(
          builder: (_) => const MenuPage(),
        );
      case AgendaPage.id:
        return MaterialPageRoute(
          builder: (_) => const AgendaPage(),
        );
      case SelectIngredientsPage.id:
        return MaterialPageRoute(
          builder: (_) => const SelectIngredientsPage(),
        );
      case CreateMealPlanPage.id:
        return MaterialPageRoute(
          builder: (_) => const CreateMealPlanPage(),
        );
      case AssignMealTimePage.id:
        final arguments =
            routeSettings.arguments as AssignMealTimePageArguments;
        return MaterialPageRoute(
          builder: (_) => AssignMealTimePage(
            arguments: arguments,
          ),
        );
      case RecipePage.id:
        return MaterialPageRoute(
          builder: (_) => const RecipePage(),
        );
      case RecipeStepsPage.id:
        final recipe = routeSettings.arguments as Recipe;
        return MaterialPageRoute(
          builder: (_) => RecipeStepsPage(recipe: recipe),
        );
      case ReminderPage.id:
        return MaterialPageRoute(
          builder: (_) => const ReminderPage(),
        );
    }
  }
}
