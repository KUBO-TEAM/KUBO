import 'package:flutter/material.dart';
import 'package:kubo/modules/reminders/states/reminder.state.dart';


class ReminderScreen extends StatelessWidget {
  static const String id = 'reminder_screen';
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReminderState();
  }
}
