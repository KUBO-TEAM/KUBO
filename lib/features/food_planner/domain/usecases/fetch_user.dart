import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/food_planner/domain/repositories/user_repository.dart';

@lazySingleton
class FetchUser implements UseCase<User, NoParams> {
  final UserRepository repository;

  FetchUser(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.fetchUser();
  }
}
