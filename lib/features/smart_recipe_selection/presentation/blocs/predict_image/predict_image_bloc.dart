import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/predict_image.dart';

part 'predict_image_event.dart';
part 'predict_image_state.dart';

@injectable
class PredictImageBloc extends Bloc<PredictImageEvent, PredictImageState> {
  final PredictImage predictImage;

  PredictImageBloc({required this.predictImage})
      : super(PredictImageInitial()) {
    on<PredictImageEvent>((event, emit) async {
      if (event is PredictImagePredicted) {
        final imagePath = event.imagePath;
        emit(PredictImageInProgress());

        final failOrPredictImage = await predictImage(File(imagePath));

        failOrPredictImage.fold(
          (failure) {
            emit(
              PredictImageFailure(),
            );
          },
          (predictedImage) async {
            emit(PredictImageSuccess(predictedImage: predictedImage));
          },
        );
      }
    });
  }
}
