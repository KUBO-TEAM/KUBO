import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/reminder.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_notifications.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

@injectable
class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final FetchReminders fetchReminders;

  ReminderBloc({
    required this.fetchReminders,
  }) : super(ReminderInitial()) {
    on<ReminderEvent>((event, emit) async {
      if (event is ReminderNotificationsFetched) {
        emit(ReminderFetchNotificationsInProgress());
        final failureOrNotifications = await fetchReminders(NoParams());

        failureOrNotifications.fold((failure) {
          emit(
            const ReminderFetchNotificationsFailure(
              message: 'Fail to fetch notifications',
            ),
          );
        }, (reminders) {
          emit(ReminderFetchNotificationsSuccess(reminders: reminders));
        });
      }
    });
  }
}
