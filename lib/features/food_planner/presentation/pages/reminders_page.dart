import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';
import 'package:kubo/features/food_planner/presentation/blocs/reminder/reminder_bloc.dart';
import 'package:kubo/features/food_planner/presentation/widgets/icon_button.dart';
import 'package:kubo/features/food_planner/presentation/widgets/list_clipper.dart';

class ReminderPage extends StatefulWidget {
  static const String id = 'reminder_page';
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReminderBloc>(context).add(ReminderNotificationsFetched());
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
                      if (state is ReminderFetchNotificationsSuccess) {
                        EasyLoading.dismiss();
                        List<Reminder> reminders = state.reminders;
                        return ListView.builder(
                            itemCount: reminders.length,
                            itemBuilder: (context, index) {
                              Reminder reminder = reminders[index];
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                child: Row(children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                      leading: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffFFE6C0),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            (index + 1).toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
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
                                        reminder.message,
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              );
                            });
                      }
                      return Container();
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
