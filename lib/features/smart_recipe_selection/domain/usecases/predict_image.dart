import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart';

@lazySingleton
class PredictImage implements UseCase<PredictedImage, File> {
  final SmartRecipeSelectionRepository repository;

  PredictImage(this.repository);

  @override
  Future<Either<Failure, PredictedImage>> call(File imageFile) async {
    return await repository.predictImage(imageFile);
  }
}
