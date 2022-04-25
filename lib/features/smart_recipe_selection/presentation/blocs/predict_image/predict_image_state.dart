part of 'predict_image_bloc.dart';

abstract class PredictImageState extends Equatable {
  const PredictImageState();

  @override
  List<Object> get props => [];
}

class PredictImageInitial extends PredictImageState {}

class PredictImageInProgress extends PredictImageState {}

class PredictImageSuccess extends PredictImageState {
  final PredictedImage predictedImage;

  const PredictImageSuccess({required this.predictedImage});
}

class PredictImageFailure extends PredictImageState {}
