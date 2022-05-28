import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/smart_recipe_selection/data/datasources/smart_recipe_selection_remote_data_source.dart';
import 'package:kubo/features/smart_recipe_selection/data/datasources/smart_recipe_selection_local_data_source.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';

import 'package:kubo/features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/delete_predicted_images.dart';

@LazySingleton(as: SmartRecipeSelectionRepository)
class SmartRecipeSelectionRepositoryImpl
    implements SmartRecipeSelectionRepository {
  final SmartRecipeSelectionRemoteDataSource
      smartRecipeSelectionRemoteDataSource;

  final SmartRecipeSelectionLocalDataSource smartRecipeSelectionLocalDataSource;

  SmartRecipeSelectionRepositoryImpl({
    required this.smartRecipeSelectionRemoteDataSource,
    required this.smartRecipeSelectionLocalDataSource,
  });

  @override
  Future<Either<Failure, PredictedImage>> predictImage(File imageFile) async {
    try {
      final predictedImage =
          await smartRecipeSelectionRemoteDataSource.predictImage(imageFile);

      return Right(predictedImage);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeSchedule>>> generateRecipeSchedules(
      List<Category> categories) async {
    try {
      final recipeSchedules = await smartRecipeSelectionRemoteDataSource
          .generateRecipeSchedules(categories);

      return Right(recipeSchedules);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CreateCategoryResponse>> createCategory(
    PredictedImage predictedImage,
  ) async {
    try {
      final createCategoryResponse = await smartRecipeSelectionLocalDataSource
          .createCategory(predictedImage);

      return Right(createCategoryResponse);
    } on ServerException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CreatePredictedImageResponse>> createPredictedImage(
      PredictedImage predictedImage) async {
    try {
      final createPredictedImage = await smartRecipeSelectionLocalDataSource
          .createPredictedImage(predictedImage);

      return Right(createPredictedImage);
    } on ServerException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<PredictedImage>>> fetchPredictedImages() async {
    try {
      final predictedImages =
          await smartRecipeSelectionLocalDataSource.fetchPredictedImages();

      return Right(predictedImages);
    } on ServerException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<PredictedImage>>>
      deleteExpiredPredictedImages() async {
    try {
      final response = await smartRecipeSelectionLocalDataSource
          .deleteExpiredPredictedImages();

      return Right(response);
    } on ServerException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, DeletePredictedImageResponse>> deletePredictedImages(
      List<PredictedImage> predictedImages) async {
    try {
      final response = await smartRecipeSelectionLocalDataSource
          .deletePredictedImages(predictedImages);

      return Right(response);
    } on ServerException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> fetchCategories() async {
    try {
      final categories =
          await smartRecipeSelectionLocalDataSource.fetchCategories();

      return Right(categories);
    } on ServerException {
      return Left(CacheFailure());
    }
  }
}
