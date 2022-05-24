import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/fetch_predicted_images.dart';

part 'scanned_pictures_list_event.dart';
part 'scanned_pictures_list_state.dart';

@injectable
class ScannedPicturesListBloc
    extends Bloc<ScannedPicturesListEvent, ScannedPicturesListState> {
  final FetchPredictedImages fetchPredictedImages;

  ScannedPicturesListBloc({
    required this.fetchPredictedImages,
  }) : super(ScannedPicturesListInitial()) {
    on<ScannedPicturesListEvent>((event, emit) async {
      if (event is ScannedPicturesListFetched) {
        emit(ScannedPicturesListInProgress());
        final failureOrPredictedImages = await fetchPredictedImages(NoParams());

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
    });
  }
}
