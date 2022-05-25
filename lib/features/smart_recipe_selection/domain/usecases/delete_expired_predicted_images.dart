import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart';

@lazySingleton
class DeleteExpiredPredictedImages
    implements UseCase<List<PredictedImage>, NoParams> {
  final SmartRecipeSelectionRepository repository;

  DeleteExpiredPredictedImages(this.repository);

  @override
  Future<Either<Failure, List<PredictedImage>>> call(NoParams params) async {
    return await repository.deleteExpiredPredictedImages();
  }
}
