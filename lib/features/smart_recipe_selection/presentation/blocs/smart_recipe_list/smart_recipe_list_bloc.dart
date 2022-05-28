import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/generate_recipe_schedules.dart';

part 'smart_recipe_list_event.dart';
part 'smart_recipe_list_state.dart';

@injectable
class SmartRecipeListBloc
    extends Bloc<SmartRecipeListEvent, SmartRecipeListState> {
  final GenerateRecipeSchedules generateRecipeSchedules;

  SmartRecipeListBloc({
    required this.generateRecipeSchedules,
  }) : super(SmartRecipeListInitial()) {
    on<SmartRecipeListEvent>((event, emit) async {
      if (event is SmartRecipeListRecipeSchedulesGenerated) {
        emit(SmartRecipeListInProgress());
        final categories = event.categories;

        final failureOrRecipeSchedules =
            await generateRecipeSchedules(categories);

        failureOrRecipeSchedules.fold(
          (fail) {
            emit(
              const SmartRecipeListFailure(
                message: 'Cannot generate recipe schedules',
              ),
            );
          },
          (recipeSchedules) {
            emit(
              SmartRecipeListSuccess(
                recipeSchedules: recipeSchedules,
              ),
            );
          },
        );
      }
    });
  }
}
