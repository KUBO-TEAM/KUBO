part of 'scanned_pictures_list_bloc.dart';

abstract class ScannedPicturesListState {
  const ScannedPicturesListState();
}

class ScannedPicturesListInitial extends ScannedPicturesListState {}

class ScannedPicturesListInProgress extends ScannedPicturesListState {}

class ScannedPicturesListSuccess extends ScannedPicturesListState {
  final List<PredictedImage> predictedImages;
  final bool? thereIsAnExpiredPredictedImage;

  const ScannedPicturesListSuccess({
    required this.predictedImages,
    this.thereIsAnExpiredPredictedImage,
  });
}

class ScannedPicturesListFailure extends ScannedPicturesListState {
  final String message;

  const ScannedPicturesListFailure({required this.message});
}
