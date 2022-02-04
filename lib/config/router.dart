import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/walk_through/splash_screen.dart';
import 'package:kubo/core/walk_through/welcome_screen.dart';
import 'package:kubo/modules/agenda/screens/agenda.screen.dart';
import 'package:kubo/modules/camera/screens/camera.screen.dart';
import 'package:kubo/modules/camera/screens/captured.screen.dart';
import 'package:kubo/modules/home/screens/home.screen.dart';
import 'package:kubo/modules/meal_plan/models/recipe.dart';
import 'package:kubo/modules/meal_plan/screens/assign_meal_time.screen.dart';
import 'package:kubo/modules/meal_plan/screens/create_meal_plan.screen.dart';
import 'package:kubo/modules/meal_plan/screens/select_ingredients.screen.dart';
import 'package:kubo/modules/menu/screens/menu.screen.dart';
import 'package:kubo/modules/menu_history/screens/menu_history.screen.dart';
import 'package:kubo/modules/recipe/screen/recipe.screen.dart';
import 'package:kubo/modules/recipe/screen/recipeSteps.screen.dart';
import 'package:kubo/modules/reminders/screen/reminders.screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case WelcomeScreen.id:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );
      case HomeScreen.id:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case CameraScreen.id:
        return MaterialPageRoute(
          builder: (_) => const CameraScreen(),
        );
      case MenuHistoryScreen.id:
        return MaterialPageRoute(
          builder: (_) => const MenuHistoryScreen(),
        );
      case CapturedScreen.id:
        return MaterialPageRoute(
          builder: (_) => const CapturedScreen(),
        );
      case MenuScreen.id:
        return MaterialPageRoute(
          builder: (_) => const MenuScreen(),
        );
      case AgendaScreen.id:
        return MaterialPageRoute(
          builder: (_) => const AgendaScreen(),
        );
      case SelectIngredientsScreen.id:
        return MaterialPageRoute(
          builder: (_) => const SelectIngredientsScreen(),
        );
      case CreateMealPlanScreen.id:
        return MaterialPageRoute(
          builder: (_) => const CreateMealPlanScreen(),
        );
      case AssignMealTimeScreen.id:
        final arguments =
            routeSettings.arguments as AssignMealTimeScreenArguments;

        return MaterialPageRoute(
          builder: (_) => AssignMealTimeScreen(
            arguments: arguments,
          ),
        );
      case RecipeScreen.id:
        return MaterialPageRoute(
          builder: (_) => const RecipeScreen(),
        );
      case RecipeSteps.id:
        final recipe = routeSettings.arguments as Recipe;
        return MaterialPageRoute(
          builder: (_) => RecipeSteps(recipe: recipe),
        );
      case ReminderScreen.id:
        return MaterialPageRoute(
          builder: (_) => const ReminderScreen(),
        );
    }
  }
}
