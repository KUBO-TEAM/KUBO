import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipes_page.dart';
import 'package:kubo/features/smart_recipe_selection/presentation/pages/scanned_pictures_list_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  final iconList = <IconData>[
    Icons.storefront,
    Icons.menu_book,
  ];

  final titleList = <String>[
    'Recipes',
    'Ingredients',
  ];

  final autoSizeGroup = AutoSizeGroup();
  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  void _navigate(int index) {
    switch (index) {
      case 0: // Navigate to recipes
        BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).add(
          CreateRecipeScheduleDialogInitializeState(),
        );

        Navigator.pushNamed(
          context,
          RecipesPage.id,
          arguments: RecipesPageArguments(),
        );
        return;
      case 1: // Navigate to scanned pictures list page;

        Navigator.pushNamed(
          context,
          ScannedPicturesListPage.id,
        );
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        activeIndex: 0,
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
