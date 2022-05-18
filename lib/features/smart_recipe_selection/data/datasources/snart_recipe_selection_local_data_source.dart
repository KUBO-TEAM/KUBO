import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/predicted_image.dart';
import 'package:kubo/features/smart_recipe_selection/domain/usecases/create_category.dart';

abstract class SmartRecipeSelectionLocalDataSource {
  /// create [RecipeScheduleModel] to the cached.
  ///
  /// Throws [CacheException] if data is not save.
  Future<CreateCategoryResponse> createCategory(PredictedImage predictedImage);
}

@LazySingleton(as: SmartRecipeSelectionLocalDataSource)
class SmartRecipeSelectionLocalDataSourceImpl
    implements SmartRecipeSelectionLocalDataSource {
  final Box<Category> categoryBox;

  SmartRecipeSelectionLocalDataSourceImpl({required this.categoryBox});

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
}
