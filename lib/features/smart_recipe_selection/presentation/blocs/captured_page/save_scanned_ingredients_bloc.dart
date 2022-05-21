import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_predicted_image.dart';

part 'save_scanned_ingredients_event.dart';
part 'save_scanned_ingredients_state.dart';

@injectable
class SaveScannedIngredientsBloc
    extends Bloc<SaveScannedIngredientsEvent, SaveScannedIngredientsState> {
  final CreatePredictedImage createPredictedImage;
  SaveScannedIngredientsBloc({
    required this.createPredictedImage,
  }) : super(SaveScannedIngredientsInitial()) {
    on<SaveScannedIngredientsEvent>((event, emit) async {
      if (event is SaveScannedIngredientsCreatedPredictedImage) {
        emit(SaveScannedIngredientsInProgress());
        final failureOrCreatePredictedImage =
            await createPredictedImage(event.predictedImage);
        failureOrCreatePredictedImage.fold((fail) {
          emit(
            const SaveScannedIngredientsFailure(
              message: 'Creating Predicted Image Fails',
            ),
          );
        }, (response) {
          emit(
            SaveScannedIngredientsSuccess(
              message: response.message,
            ),
          );
        });
      }
    });
  }
}
