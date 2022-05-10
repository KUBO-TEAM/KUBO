part of 'reminder_bloc.dart';

abstract class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object> get props => [];
}

class ReminderNotificationsFetched extends ReminderEvent {}
