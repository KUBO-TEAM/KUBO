import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipes_page.dart';
import 'package:kubo/features/food_planner/presentation/pages/reminders_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  final iconList = <IconData>[
    Icons.storefront,
    // Icons.menu_book,
    // Icons.home,
    Icons.notifications,
  ];

  final titleList = <String>[
    'Recipes',
    // 'Ingredients',
    // 'Home',
    'Reminders',
  ];

  final autoSizeGroup = AutoSizeGroup();
  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  void _navigate(int index) {
    switch (index) {
      case 0: // Navigate to recipes
        Navigator.pushNamed(
          context,
          RecipesPage.id,
          arguments: RecipesPageArguments(),
        );
        return;
      case 1: // Navigate to reminders;

        Navigator.pushNamed(context, ReminderPage.id);
        return;
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      const Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  Badge _buildRemindersBadgedIcon(IconData icon) {
    return Badge(
      badgeColor: Colors.red.shade700,
      badgeContent: const Text(
        '6',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Icon(
        icon,
        size: 24,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (index == 1) _buildRemindersBadgedIcon(iconList[index]),
              if (index == 0)
                Icon(
                  iconList[index],
                  size: 24,
                  color: Colors.white,
                ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  titleList[index],
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white),
                  group: autoSizeGroup,
                ),
              )
            ],
          );
        },
        backgroundColor: kBrownPrimary,
        activeIndex: 2,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          _navigate(index);
        });
  }
}
