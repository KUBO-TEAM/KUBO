import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kubo/core/hive/objects/recipe_schedule_hive.dart';
import 'package:mockito/mockito.dart';

import '../../../test_constants.dart';

void main() {
  final tRecipeScheduleHive = RecipeScheduleHive(
    id: tId,
    name: tName,
    description: tDescription,
    imageUrl: tImageUrl,
    start: tStart,
    end: tEnd,
    color: tColor,
  );

  test('should be a subclass of HiveObject', () {
    expect(tRecipeScheduleHive, isA<HiveObject>());
  });
}
