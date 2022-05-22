part of 'scanned_pictures_list_bloc.dart';

abstract class ScannedPicturesListState extends Equatable {
  const ScannedPicturesListState();

  @override
  List<Object> get props => [];
}

class ScannedPicturesListInitial extends ScannedPicturesListState {}

class ScannedPicturesListInProgress extends ScannedPicturesListState {}

class ScannedPicturesListSuccess extends ScannedPicturesListState {
  final List<PredictedImage> predictedImages;

  const ScannedPicturesListSuccess({required this.predictedImages});
}

class ScannedPicturesListFailure extends ScannedPicturesListState {
  final String message;

  const ScannedPicturesListFailure({required this.message});
}
