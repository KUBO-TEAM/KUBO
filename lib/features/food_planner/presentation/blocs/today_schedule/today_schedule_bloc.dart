import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_today_recipe_schedule.dart';

part 'today_schedule_event.dart';
part 'today_schedule_state.dart';

@injectable
class TodayScheduleBloc extends Bloc<TodayScheduleEvent, TodayScheduleState> {
  final FetchTodaySchedule fetchTodaySchedule;

  TodayScheduleBloc({
    required this.fetchTodaySchedule,
  }) : super(TodayScheduleInitial()) {
    on<TodayScheduleEvent>((event, emit) async {
      if (event is TodayScheduleFetched) {
        emit(TodayScheduleInProgress());

        final failureOrRecipeSchedule = await fetchTodaySchedule(NoParams());

        failureOrRecipeSchedule.fold(
          (failure) {
            emit(
              const TodayScheduleFailure(
                  message: 'Cannot fetch today schedule'),
            );
          },
          (recipeSchedule) {
            emit(
              TodayScheduleSuccess(
                recipeSchedule: recipeSchedule,
              ),
            );
          },
        );
      }
    });
  }
}
