part of 'save_scanned_ingredients_bloc.dart';

abstract class SaveScannedIngredientsEvent extends Equatable {
  const SaveScannedIngredientsEvent();

  @override
  List<Object> get props => [];
}

class SaveScannedIngredientsCreatedPredictedImage
    extends SaveScannedIngredientsEvent {
  final PredictedImage predictedImage;

  const SaveScannedIngredientsCreatedPredictedImage({
    required this.predictedImage,
  });
}
