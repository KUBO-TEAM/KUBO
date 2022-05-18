import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/features/smart_recipe_selection/data/datasources/smart_recipe_selection_remote_data_source.dart';
import 'package:kubo/features/smart_recipe_selection/data/datasources/snart_recipe_selection_local_data_source.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';

import 'package:kubo/features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_category.dart';

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
  Future<Either<Failure, CreateCategoryResponse>> createCategory(
    PredictedImage predictedImage,
  ) async {
    try {
      final createCategoryResponse = await smartRecipeSelectionLocalDataSource
          .createCategory(predictedImage);

      return Right(createCategoryResponse);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
