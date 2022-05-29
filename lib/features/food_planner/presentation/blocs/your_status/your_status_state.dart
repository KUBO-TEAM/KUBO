part of 'your_status_bloc.dart';

abstract class YourStatusState {
  const YourStatusState();
}

class YourStatusInitial extends YourStatusState {}

class YourStatusInProgress extends YourStatusState {}

class YourStatusSuccess extends YourStatusState {
  final int? recipeSchedulesLength;
  final int? categoriesLength;

  const YourStatusSuccess({
    this.recipeSchedulesLength,
    this.categoriesLength,
  });
}

class YourStatusFailure extends YourStatusState {
  final String message;

  const YourStatusFailure({required this.message});
}
