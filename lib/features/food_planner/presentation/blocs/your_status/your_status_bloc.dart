import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedules_length.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/fetch_recipe_schedules_length.dart';

part 'your_status_event.dart';
part 'your_status_state.dart';

@injectable
class YourStatusBloc extends Bloc<YourStatusEvent, YourStatusState> {
  final FetchCategoriesLength fetchCategoriesLength;
  final FetchRecipeSchedulesLength fetchRecipeSchedulesLength;

  YourStatusBloc({
    required this.fetchCategoriesLength,
    required this.fetchRecipeSchedulesLength,
  }) : super(YourStatusInitial()) {
    on<YourStatusEvent>((event, emit) async {
      if (event is YourStatusFetched) {
        emit(YourStatusInProgress());

        final failureOrCategoriesLength =
            await fetchCategoriesLength(NoParams());

        await failureOrCategoriesLength.fold((failure) {},
            (categoriesLength) async {
          final failureOrRecipeShedulesLength =
              await fetchRecipeSchedulesLength(NoParams());

          failureOrRecipeShedulesLength.fold((failure) {},
              (recipeSchedulesLength) {
            emit(
              YourStatusSuccess(
                categoriesLength: categoriesLength,
                recipeSchedulesLength: recipeSchedulesLength,
              ),
            );
          });
        });
      }
    });
  }
}
