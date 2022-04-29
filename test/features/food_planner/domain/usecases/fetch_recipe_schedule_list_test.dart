import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_recipe_schedule_list.dart';
import 'package:mockito/mockito.dart';

// import 'create_recipe_schedule_test.mocks.dart';

// void main() {
//   late MockRecipeScheduleRepository mockRecipeScheduleRepository;
//   late FetchRecipeScheduleList fetchRecipeScheduleList;

//   setUp(() {
//     mockRecipeScheduleRepository = MockRecipeScheduleRepository();
//     fetchRecipeScheduleList =
//         FetchRecipeScheduleList(mockRecipeScheduleRepository);
//   });

//   final List<RecipeSchedule> tRecipeScheduleList = [];

//   test('should fetch list of RecipeSchedule from the repository', () async {
//     when(mockRecipeScheduleRepository.fetchRecipeScheduleList())
//         .thenAnswer((_) async => Right(tRecipeScheduleList));

//     final result = await fetchRecipeScheduleList(NoParams());

//     expect(result, equals(Right(tRecipeScheduleList)));
//     verify(mockRecipeScheduleRepository.fetchRecipeScheduleList());
//   });
// }
