import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart';

@lazySingleton
class CreateCategory
    implements UseCase<CreateCategoryResponse, PredictedImage> {
  final SmartRecipeSelectionRepository repository;

  CreateCategory(this.repository);

  @override
  Future<Either<Failure, CreateCategoryResponse>> call(
      PredictedImage predictedImage) async {
    return await repository.createCategory(predictedImage);
  }
}

class CreateCategoryResponse extends Equatable {
  final String message;

  const CreateCategoryResponse({required this.message});

  @override
  List<Object?> get props => [message];
}
