import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_generate_recipe_schedules.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/generate_recipe_schedules.dart';

part 'smart_recipe_list_event.dart';
part 'smart_recipe_list_state.dart';

@injectable
class SmartRecipeListBloc
    extends Bloc<SmartRecipeListEvent, SmartRecipeListState> {
  final GenerateRecipeSchedules generateRecipeSchedules;
  final CreateGenerateRecipeSchedules createGenerateRecipeSchedules;

  SmartRecipeListBloc({
    required this.generateRecipeSchedules,
    required this.createGenerateRecipeSchedules,
  }) : super(SmartRecipeListInitial()) {
    on<SmartRecipeListEvent>((event, emit) async {
      if (event is SmartRecipeListRecipeSchedulesGenerated) {
        emit(SmartRecipeListFetchInProgress());
        final categories = event.categories;

        final failureOrRecipeSchedules =
            await generateRecipeSchedules(categories);

        failureOrRecipeSchedules.fold(
          (fail) {
            emit(
              const SmartRecipeListFetchFailure(
                message: 'Cannot generate recipe schedules',
              ),
            );
          },
          (recipeSchedules) {
            emit(
              SmartRecipeListFetchSuccess(
                recipeSchedules: recipeSchedules,
              ),
            );
          },
        );
      } else if (event is SmartRecipeListRecipeSchedulesSaved) {
        final recipeSchedules = event.recipeSchedules;
        final user = event.user;

        for (var recipeSchedule in recipeSchedules) {
          await Utils.scheduleNotificationWithUser(
            start: recipeSchedule.start,
            recipe: recipeSchedule.recipe,
            user: user,
          );
        }

        await createGenerateRecipeSchedules(
          recipeSchedules,
        );

        emit(
          const SmartRecipeListCreateSuccess(
            message: 'Successfully save schedules!',
          ),
        );

        emit(
          SmartRecipeListFetchSuccess(
            recipeSchedules: recipeSchedules,
          ),
        );
      }
    });
  }
}
