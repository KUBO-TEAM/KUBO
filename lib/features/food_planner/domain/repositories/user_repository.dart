import 'package:dartz/dartz.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> fetchUser();
  Future<Either<Failure, User>> initializeUser();
}
