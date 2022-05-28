import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:kubo/core/constants/string_constants.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/features/food_planner/data/models/recipe_schedule_model.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/smart_recipe_selection/data/models/predicted_image_model.dart';
import 'package:http/http.dart' as http;
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';

abstract class SmartRecipeSelectionRemoteDataSource {
  /// fetch [PredictedImageModel] in remote
  ///
  /// Throws [ServerException] if no remote data is present.
  ///
  Future<PredictedImageModel> predictImage(File imageFile);

  Future<List<RecipeSchedule>> generateRecipeSchedules(
    List<Category> categories,
  );
}

@LazySingleton(as: SmartRecipeSelectionRemoteDataSource)
class SmartRecipeSelectionRemoteDataSourceImpl
    implements SmartRecipeSelectionRemoteDataSource {
  final http.Client client;

  SmartRecipeSelectionRemoteDataSourceImpl({required this.client});

  @override
  Future<PredictedImageModel> predictImage(File imageFile) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$kKuboUrl/api/yolov4/detect'),
    );

    request.files.add(http.MultipartFile(
      'image',
      imageFile.readAsBytes().asStream(),
      imageFile.lengthSync(),
      filename: 'image',
    ));

    final response = await request.send();
    final responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var responseData = json.decode(responsed.body);
      return PredictedImageModel.fromJson(responseData['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecipeSchedule>> generateRecipeSchedules(
      List<Category> categories) async {
    try {
      List<Map<String, dynamic>> categoriesArrayMap = [];

      for (Category category in categories) {
        categoriesArrayMap.add(category.toMap());
      }

      final response = await client.post(
        Uri.parse('$kKuboUrl/api/generate-schedule'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            "categories": categoriesArrayMap,
            "clientCurrentTime": DateTime.now().toIso8601String(),
          },
        ),
      );
      if (response.statusCode == 200) {
        var body = json.decode(response.body);

        var data = body['data'];

        List<RecipeSchedule> recipeSchedules = [];

        for (var value in data) {
          recipeSchedules.add(RecipeScheduleModel.fromJson(value));
        }

        return recipeSchedules;
      } else {
        throw ServerException();
      }
    } on Exception {
      throw ServerException();
    }
  }
}
