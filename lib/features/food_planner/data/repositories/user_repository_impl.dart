import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kubo/features/food_planner/data/datasources/user_local_data_source.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/food_planner/domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;

  UserRepositoryImpl(
    this.userLocalDataSource,
  );

  @override
  Future<Either<Failure, User>> fetchUser() async {
    try {
      final response = await userLocalDataSource.fetchUser();

      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> initializeUser() async {
    try {
      final response = await userLocalDataSource.initializeUser();

      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
