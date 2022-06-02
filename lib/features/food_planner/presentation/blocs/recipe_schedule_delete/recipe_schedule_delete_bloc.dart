import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/delete_recipe_schedule.dart';

part 'recipe_schedule_delete_event.dart';
part 'recipe_schedule_delete_state.dart';

@injectable
class RecipeScheduleDeleteBloc
    extends Bloc<RecipeScheduleDeleteEvent, RecipeScheduleDeleteState> {
  final DeleteRecipeSchedule deleteRecipeSchedule;

  RecipeScheduleDeleteBloc({
    required this.deleteRecipeSchedule,
  }) : super(RecipeScheduleDeleteInitial()) {
    on<RecipeScheduleDeleteEvent>((event, emit) async {
      if (event is RecipeScheduleDeleted) {
        final recipeSchedule = event.recipeSchedule;

        final failureOrDeleteRecipeScheduleResponse =
            await deleteRecipeSchedule(recipeSchedule);

        failureOrDeleteRecipeScheduleResponse.fold(
          (failure) {
            emit(
              const RecipeScheduleDeleteFailure(
                message: 'Failed to Delete schedule',
              ),
            );
          },
          (response) {
            emit(RecipeScheduleDeleteSuccess(message: response.message));
          },
        );
      }
    });
  }
}
