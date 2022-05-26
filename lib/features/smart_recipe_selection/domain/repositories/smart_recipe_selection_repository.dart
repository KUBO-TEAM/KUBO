import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/delete_predicted_images.dart';

abstract class SmartRecipeSelectionRepository {
  Future<Either<Failure, PredictedImage>> predictImage(File imageFile);
  Future<Either<Failure, CreateCategoryResponse>> createCategory(
    PredictedImage predictedImage,
  );

  Future<Either<Failure, CreatePredictedImageResponse>> createPredictedImage(
    PredictedImage predictedImage,
  );

  Future<Either<Failure, List<Category>>> fetchCategories();

  Future<Either<Failure, List<PredictedImage>>> fetchPredictedImages();

  Future<Either<Failure, List<PredictedImage>>> deleteExpiredPredictedImages();
  Future<Either<Failure, DeletePredictedImageResponse>> deletePredictedImages(
    List<PredictedImage> predictedImages,
  );
}
