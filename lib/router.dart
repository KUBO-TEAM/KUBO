import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/widgets/splash_page.dart';
import 'package:kubo/core/widgets/welcome_page.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/presentation/pages/agenda_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/assign_meal_time_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/create_meal_plan_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/home_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/menu_history_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/menu_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipes_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_info_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/reminders_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/camera_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/captured_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/scanned_pictures_list_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/smart_recipe_list_page.dart';

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

      /** Food Planner Feature */
      case HomePage.id:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case MenuHistoryPage.id:
        return MaterialPageRoute(
          builder: (_) => const MenuHistoryPage(),
        );
      case MenuPage.id:
        return MaterialPageRoute(
          builder: (_) => const MenuPage(),
        );
      case AgendaPage.id:
        return MaterialPageRoute(
          builder: (_) => const AgendaPage(),
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
      case RecipesPage.id:
        final arguments = routeSettings.arguments as RecipesPageArguments;

        return MaterialPageRoute(
          builder: (_) => RecipesPage(
            arguments: arguments,
          ),
        );
      case RecipeInfoPage.id:
        final recipe = routeSettings.arguments as Recipe;
        return MaterialPageRoute(
          builder: (_) => RecipeInfoPage(recipe: recipe),
        );
      case ReminderPage.id:
        return MaterialPageRoute(
          builder: (_) => const ReminderPage(),
        );

      /** Smart Recipe Selection Feature */
      case CameraPage.id:
        return MaterialPageRoute(
          builder: (_) => const CameraPage(),
        );

      case CapturedPage.id:
        final arguments = routeSettings.arguments as CapturedPageArguments;

        return MaterialPageRoute(
          builder: (_) => CapturedPage(arguments: arguments),
        );
      case ScannedPicturesListPage.id:
        final arguments =
            routeSettings.arguments as ScannedPicturesListPageArguments;

        return MaterialPageRoute(
          builder: (_) => ScannedPicturesListPage(arguments: arguments),
        );

      case SmartRecipeListPage.id:
        return MaterialPageRoute(
          builder: (_) => const SmartRecipeListPage(),
        );
    }
    return null;
  }
}
