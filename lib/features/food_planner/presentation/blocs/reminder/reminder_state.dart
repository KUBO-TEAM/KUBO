part of 'reminder_bloc.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object> get props => [];
}

class ReminderInitial extends ReminderState {}

class ReminderFetchNotificationsInProgress extends ReminderState {}

class ReminderFetchNotificationsSuccess extends ReminderState {
  final List<Reminder> reminders;

  const ReminderFetchNotificationsSuccess({required this.reminders});
}

class ReminderFetchNotificationsFailure extends ReminderState {
  final String message;

  const ReminderFetchNotificationsFailure({required this.message});
}
