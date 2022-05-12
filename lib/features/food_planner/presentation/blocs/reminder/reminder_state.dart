part of 'reminder_bloc.dart';

abstract class ReminderState {
  const ReminderState();
}

class ReminderFetchNotificationsInitial extends ReminderState {}

class ReminderFetchNotificationsInProgress extends ReminderState {
  final List<Reminder>? reminders;
  final int? unseenReminders;

  const ReminderFetchNotificationsInProgress({
    this.reminders,
    this.unseenReminders,
  });
}

class ReminderFetchNotificationsSuccess extends ReminderState {
  final List<Reminder> reminders;
  final int unseenReminders;

  const ReminderFetchNotificationsSuccess({
    required this.reminders,
    required this.unseenReminders,
  });
}

class ReminderFetchNotificationsFailure extends ReminderState {
  final String message;

  const ReminderFetchNotificationsFailure({required this.message});
}
