import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/smart_recipe_selection/domain/repositories/smart_recipe_selection_repository.dart';

@lazySingleton
class FetchCategoriesLength implements UseCase<int, NoParams> {
  final SmartRecipeSelectionRepository repository;

  FetchCategoriesLength(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await repository.fetchCategoriesLength();
  }
}
