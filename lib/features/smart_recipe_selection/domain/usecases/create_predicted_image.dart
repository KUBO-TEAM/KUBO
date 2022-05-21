import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart';

@lazySingleton
class CreatePredictedImage
    implements UseCase<CreatePredictedImageResponse, PredictedImage> {
  final SmartRecipeSelectionRepository repository;

  CreatePredictedImage(this.repository);

  @override
  Future<Either<Failure, CreatePredictedImageResponse>> call(
      PredictedImage predictedImage) async {
    return await repository.createPredictedImage(predictedImage);
  }
}

class CreatePredictedImageResponse extends Equatable {
  final String message;

  const CreatePredictedImageResponse({required this.message});

  @override
  List<Object?> get props => [message];
}
