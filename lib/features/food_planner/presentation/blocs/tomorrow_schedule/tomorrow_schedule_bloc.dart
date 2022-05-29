import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_tomorrow_recipe_schedule.dart';

part 'tomorrow_schedule_event.dart';
part 'tomorrow_schedule_state.dart';

@injectable
class TomorrowScheduleBloc
    extends Bloc<TomorrowScheduleEvent, TomorrowScheduleState> {
  final FetchTomorrowSchedule fetchTomorrowSchedule;

  TomorrowScheduleBloc({
    required this.fetchTomorrowSchedule,
  }) : super(TomorrowScheduleInitial()) {
    on<TomorrowScheduleEvent>((event, emit) async {
      if (event is TomorrowScheduleFetched) {
        emit(TomorrowScheduleInProgress());

        final failureOrRecipeSchedule = await fetchTomorrowSchedule(NoParams());

        failureOrRecipeSchedule.fold(
          (failure) {
            emit(
              const TomorrowScheduleFailure(
                  message: 'Cannot fetch tomorrow schedule'),
            );
          },
          (recipeSchedule) {
            emit(
              TomorrowScheduleSuccess(
                recipeSchedule: recipeSchedule,
              ),
            );
          },
        );
      }
    });
  }
}
