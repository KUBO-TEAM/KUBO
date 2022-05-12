import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/blocs/create_recipe_schedule_dialog/create_recipe_schedule_dialog_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/reminder/reminder_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/user/user_bloc.dart';
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

        BlocProvider.of<CreateRecipeScheduleDialogBloc>(context).add(
          CreateRecipeScheduleDialogInitializeState(),
        );

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

  BlocListener _buildRemindersBadgedIcon(IconData icon) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          BlocProvider.of<ReminderBloc>(context).add(
            ReminderNotificationsFetched(user: state.user),
          );
        }
      },
      child: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          int notification = 0;

          if (state is ReminderFetchNotificationsSuccess) {
            notification = state.unseenReminders;
          }

          return Badge(
            showBadge: notification == 0 ? false : true,
            badgeColor: Colors.red.shade700,
            badgeContent: Text(
              notification.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            child: Icon(
              icon,
              size: 24,
              color: Colors.white,
            ),
          );
        },
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
