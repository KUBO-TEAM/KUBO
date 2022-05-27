import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/reminder/reminder_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/user/user_bloc.dart';

class ReminderBell extends StatelessWidget {
  const ReminderBell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Badge(
              position: BadgePosition.topEnd(top: 0, end: 3),
              animationDuration: const Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              showBadge: notification != 0 ? true : false,
              badgeColor: Colors.red.shade700,
              badgeContent: Text(
                notification.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
