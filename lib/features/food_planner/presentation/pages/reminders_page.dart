import 'package:flutter/material.dart';
import 'package:kubo/modules/reminders/states/reminder.state.dart';


class ReminderPage extends StatelessWidget {
  static const String id = 'reminder_page';
  const ReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ReminderState();
  }
}
