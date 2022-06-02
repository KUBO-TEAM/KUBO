import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/failures.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/food_planner/domain/repositories/reminder_repository.dart';

@lazySingleton
class CreateRecipeScheduleReminder
    implements UseCase<CreateRecipeScheduleReminderResponse, RecipeSchedule> {
  final ReminderRepository repository;

  CreateRecipeScheduleReminder(this.repository);

  @override
  Future<Either<Failure, CreateRecipeScheduleReminderResponse>> call(
    RecipeSchedule params,
  ) async {
    return await repository.createRecipeScheduleReminder(params);
  }
}

class CreateRecipeScheduleReminderResponse extends Equatable {
  final String message;

  const CreateRecipeScheduleReminderResponse({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
