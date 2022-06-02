import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';
import 'package:kubo/features/food_planner/presentation/blocs/reminder/reminder_bloc.dart';
import 'package:kubo/features/food_planner/presentation/blocs/user/user_bloc.dart';
import 'package:kubo/features/food_planner/presentation/pages/recipe_info_page.dart';
import 'package:kubo/features/food_planner/presentation/widgets/empty_state.dart';
import 'package:kubo/features/food_planner/presentation/widgets/icon_button.dart';
import 'package:kubo/features/food_planner/presentation/widgets/list_clipper.dart';

class ReminderPage extends StatefulWidget {
  static const String id = 'reminder_page';
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  int? unseenRemindersState;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<UserBloc>(context).add(UserReminderSeenAtUpdated());

    UserState userState = BlocProvider.of<UserBloc>(context).state;

    if (userState is UserSuccess) {
      BlocProvider.of<ReminderBloc>(context).add(
        ReminderNotificationsFetched(user: userState.user),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenPrimary,
      body: SafeArea(
        child: Stack(
          children: [
            const ListClipper(
              color: Colors.white,
            ),
            Column(
              children: [
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CostumeIconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: kGreenPrimary,
                            size: 24.0,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Spacer(),
                        const Text(
                          "Reminders",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Montserrat Bold',
                          ),
                        ),
                        const Spacer(),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<ReminderBloc, ReminderState>(
                    builder: (context, state) {
                      if (state is ReminderFetchNotificationsInProgress) {
                        EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black,
                        );
                      }

                      if (state is ReminderFetchNotificationsFailure) {
                        EasyLoading.dismiss();
                      }

                      if (state is ReminderFetchNotificationsSuccess) {
                        EasyLoading.dismiss();

                        unseenRemindersState ??= state.unseenReminders;

                        final unseenReminders = unseenRemindersState;

                        List<Reminder> reminders = state.reminders;

                        if (reminders.isEmpty) {
                          return const EmptyState(
                            message: 'No reminders found',
                            assetImageUrl: "assets/images/empty_1.png",
                          );
                        }

                        return ListView.builder(
                          itemCount: reminders.length,
                          itemBuilder: (context, index) {
                            Reminder reminder = reminders[index];
                            Color? unseenColor = unseenReminders != null &&
                                    unseenReminders > index
                                ? Colors.green.withOpacity(0.1)
                                : null;
                            return InkWell(
                              onTap: () {
                                final recipeSchedule = reminder.recipeSchedule;
                                if (recipeSchedule != null) {
                                  Navigator.pushNamed(
                                    context,
                                    RecipeInfoPage.id,
                                    arguments: RecipeInfoPageArguments(
                                      recipe: recipeSchedule.recipe,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: unseenColor,
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/logo.png',
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          reminder.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        subtitle: Text(
                                          DateFormat.yMMMEd('en_US')
                                              .add_jm()
                                              .format(reminder.createdAt),
                                          style: const TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const EmptyState(
                        message: 'No reminders found',
                        assetImageUrl: "assets/images/empty_1.png",
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
