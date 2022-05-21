import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_predicted_image.dart';

abstract class SmartRecipeSelectionRepository {
  Future<Either<Failure, PredictedImage>> predictImage(File imageFile);
  Future<Either<Failure, CreateCategoryResponse>> createCategory(
    PredictedImage predictedImage,
  );

  Future<Either<Failure, CreatePredictedImageResponse>> createPredictedImage(
    PredictedImage predictedImage,
  );
}
