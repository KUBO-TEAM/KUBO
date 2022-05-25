import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart';

@lazySingleton
class DeletePredictedImages
    implements UseCase<DeletePredictedImageResponse, List<PredictedImage>> {
  final SmartRecipeSelectionRepository repository;

  DeletePredictedImages(this.repository);

  @override
  Future<Either<Failure, DeletePredictedImageResponse>> call(
      List<PredictedImage> params) async {
    return await repository.deletePredictedImages(params);
  }
}

class DeletePredictedImageResponse extends Equatable {
  final String message;

  const DeletePredictedImageResponse({required this.message});

  @override
  List<Object?> get props => [message];
}
