part of 'predict_image_bloc.dart';

abstract class PredictImageEvent extends Equatable {
  const PredictImageEvent();

  @override
  List<Object> get props => [];
}

class PredictImagePredicted extends PredictImageEvent {
  final String imagePath;

  const PredictImagePredicted({required this.imagePath});
}
