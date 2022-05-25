import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/delete_expired_predicted_images.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/delete_predicted_images.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/fetch_predicted_images.dart';

part 'scanned_pictures_list_event.dart';
part 'scanned_pictures_list_state.dart';

@injectable
class ScannedPicturesListBloc
    extends Bloc<ScannedPicturesListEvent, ScannedPicturesListState> {
  final FetchPredictedImages fetchPredictedImages;
  final DeleteExpiredPredictedImages deleteExpiredPredictedImages;
  final DeletePredictedImages deletePredictedImages;

  Future<void>
      _eitherPredictedImagesLoadedWithExpiredPredictedImagesMarkedOrFailure(
    Emitter<ScannedPicturesListState> emit,
    Either<Failure, List<PredictedImage>> failureOrPredictedImages,
  ) async {
    failureOrPredictedImages.fold((failure) {}, (predictedImages) {
      emit(
        ScannedPicturesListSuccess(
          predictedImages: predictedImages,
        ),
      );

      for (var predictedImage in predictedImages) {
        if (Utils.isPredictedImageExpired(predictedImage.predictedAt)) {
          emit(
            ScannedPicturesListSuccess(
              predictedImages: predictedImages,
              thereIsAnExpiredPredictedImage: true,
            ),
          );

          break;
        }
      }
    });
  }

  ScannedPicturesListBloc({
    required this.fetchPredictedImages,
    required this.deleteExpiredPredictedImages,
    required this.deletePredictedImages,
  }) : super(ScannedPicturesListInitial()) {
    on<ScannedPicturesListEvent>((event, emit) async {
      if (event is ScannedPicturesListFetched) {
        emit(ScannedPicturesListInProgress());
        final failureOrPredictedImages = await fetchPredictedImages(NoParams());

        await _eitherPredictedImagesLoadedWithExpiredPredictedImagesMarkedOrFailure(
          emit,
          failureOrPredictedImages,
        );
      } else if (event is ScannedPicturesListExpiredPredictedImagesDeleted) {
        final failureOrPredictedImages =
            await deleteExpiredPredictedImages(NoParams());

        await _eitherPredictedImagesLoadedWithExpiredPredictedImagesMarkedOrFailure(
          emit,
          failureOrPredictedImages,
        );
      } else if (event is ScannedPicturesListPredictedImagesDeleted) {
        final predictedImages = event.predictedImages;
        final failureOrDeletePredictedImageResponse =
            await deletePredictedImages(predictedImages);

        await failureOrDeletePredictedImageResponse.fold((l) {}, (res) async {
          final failureOrPredictedImages =
              await fetchPredictedImages(NoParams());

          await _eitherPredictedImagesLoadedWithExpiredPredictedImagesMarkedOrFailure(
            emit,
            failureOrPredictedImages,
          );
        });
      }
    });
  }
}
