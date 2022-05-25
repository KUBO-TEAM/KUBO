import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/helpers/utils.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/delete_predicted_images.dart';

abstract class SmartRecipeSelectionLocalDataSource {
  /// create [RecipeScheduleModel] to the cached.
  ///
  /// Throws [CacheException] if data is not save.
  Future<CreateCategoryResponse> createCategory(PredictedImage predictedImage);

  Future<CreatePredictedImageResponse> createPredictedImage(
    PredictedImage predictedImage,
  );

  Future<List<PredictedImage>> fetchPredictedImages();

  Future<List<PredictedImage>> deleteExpiredPredictedImages();

  Future<DeletePredictedImageResponse> deletePredictedImages(
      List<PredictedImage> predictedImages);
}

@LazySingleton(as: SmartRecipeSelectionLocalDataSource)
class SmartRecipeSelectionLocalDataSourceImpl
    implements SmartRecipeSelectionLocalDataSource {
  final Box<Category> categoryBox;
  final Box<PredictedImage> predictedImageBox;

  SmartRecipeSelectionLocalDataSourceImpl({
    required this.categoryBox,
    required this.predictedImageBox,
  });

  @override
  Future<CreateCategoryResponse> createCategory(
    PredictedImage predictedImage,
  ) async {
    final imageUrl = predictedImage.imageUrl;
    final categories = predictedImage.categories;

    for (var category in categories) {
      final categoryModel = Category(
        imageUrl: imageUrl,
        accuracy: category.accuracy,
        name: category.name,
        predictedAt: category.predictedAt,
      );
      categoryBox.add(categoryModel);
    }

    return const CreateCategoryResponse(
      message: 'Successfully Create Category!',
    );
  }

  @override
  Future<CreatePredictedImageResponse> createPredictedImage(
    PredictedImage predictedImage,
  ) async {
    predictedImageBox.add(predictedImage);
    return const CreatePredictedImageResponse(
      message: 'Successfully Created PredictedImage',
    );
  }

  @override
  Future<List<PredictedImage>> fetchPredictedImages() async {
    return predictedImageBox.values.toList();
  }

  @override
  Future<List<PredictedImage>> deleteExpiredPredictedImages() async {
    final predictedImages = predictedImageBox.values.toList();

    List<PredictedImage> nonExpiredPredictedImages = [];

    for (PredictedImage predictedImage in predictedImages) {
      final predictedAt = predictedImage.predictedAt;

      if (Utils.isPredictedImageExpired(predictedAt)) {
        predictedImage.delete();
      } else {
        nonExpiredPredictedImages.add(predictedImage);
      }
    }

    return nonExpiredPredictedImages;
  }

  @override
  Future<DeletePredictedImageResponse> deletePredictedImages(
      List<PredictedImage> predictedImages) async {
    //TODO:  external images not been delete only the hives one deleted
    for (PredictedImage predictedImage in predictedImages) {
      predictedImage.delete();
    }

    return const DeletePredictedImageResponse(
      message: 'Successfully deleted the predicted images !',
    );
  }
}
