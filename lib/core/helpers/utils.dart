import 'dart:io';

import 'package:kubo/core/constants/date_time_constants.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category_with_quantity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class Utils {
  static Future<String> downloadFile(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);

    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static bool isPredictedImageExpired(DateTime date) {
    final expirationDate = date.add(kGlobalVegetablesExpirationDurationDate);

    final isExpired = expirationDate.isBefore(DateTime.now());

    return isExpired;
  }

  static List<CategoryWithQuantity> fixRepeatingCategories(
      List<Category> categories) {
    Map resultedMap = {};

    for (Category category in categories) {
      if (resultedMap.containsKey(category.name)) {
        resultedMap[category.name] = {
          'quantity': resultedMap[category.name]['quantity'] + 1,
          'category': category
        };
      } else {
        resultedMap[category.name] = {
          'quantity': 1,
          'category': category,
        };
      }
    }

    return resultedMap.entries
        .map(
          (entry) => CategoryWithQuantity(
            quantity: entry.value['quantity'],
            category: entry.value['category'],
          ),
        )
        .toList();
  }

  static String toPercentage(double num) {
    final timeHundred = num * 100;
    return '${timeHundred.toStringAsFixed(2)}%';
  }
}
