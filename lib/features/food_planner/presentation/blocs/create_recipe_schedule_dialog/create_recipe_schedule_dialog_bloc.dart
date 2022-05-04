import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/list_costants.dart';

part 'create_recipe_schedule_dialog_event.dart';
part 'create_recipe_schedule_dialog_state.dart';

class CreateRecipeScheduleDialogBloc extends Bloc<
    CreateRecipeScheduleDialogEvent, CreateRecipeScheduleDialogState> {
  CreateRecipeScheduleDialogBloc()
      : super(CreateRecipeScheduleDialogInitial()) {
    on<CreateRecipeScheduleDialogEvent>((event, emit) async {
      if (event is CreateRecipeScheduleDialogInitializeState) {
        emit(CreateRecipeScheduleDialogInitial());
      } else if (event is CreateRecipeScheduleDialogDateTimeSaved) {
        final startedTime = event.startedTime;

        emit(CreateRecipeScheduleDialogInProgress());

        final start = _dateTimeToTimeOfDay(startedTime);

        final end = _dateTimeToTimeOfDay(
          startedTime.add(
            const Duration(hours: 1),
          ),
        );

        final day = kDayList.indexOf(
          DateFormat('EEEE').format(event.startedTime),
        );

        if (start != null && end != null) {
          emit(
            CreateRecipeScheduleDialogSuccess(
              start: start,
              end: end,
              day: day,
            ),
          );
        } else {
          emit(
            const CreateRecipeScheduleDialogFailure(
              message: 'Cannot convert date time to time of day',
            ),
          );
        }
      }
    });
  }

  TimeOfDay? _dateTimeToTimeOfDay(DateTime? time) {
    if (time == null) {
      return null;
    }

    return TimeOfDay(hour: time.hour, minute: time.minute);
  }
}
