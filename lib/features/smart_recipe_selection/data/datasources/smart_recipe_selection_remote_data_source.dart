import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:kubo/core/constants/string_constants.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/features/smart_recipe_selection/data/models/predicted_image_model.dart';
import 'package:http/http.dart' as http;

abstract class SmartRecipeSelectionRemoteDataSource {
  /// fetch [PredictedImageModel] in remote
  ///
  /// Throws [ServerException] if no remote data is present.
  ///
  Future<PredictedImageModel> predictImage(File imageFile);
}

@LazySingleton(as: SmartRecipeSelectionRemoteDataSource)
class SmartRecipeSelectionRemoteDataSourceImpl
    implements SmartRecipeSelectionRemoteDataSource {
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

  basename(String path) {}
}
