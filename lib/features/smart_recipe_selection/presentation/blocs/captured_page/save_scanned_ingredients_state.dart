part of 'save_scanned_ingredients_bloc.dart';

abstract class SaveScannedIngredientsState extends Equatable {
  const SaveScannedIngredientsState();

  @override
  List<Object> get props => [];
}

class SaveScannedIngredientsInitial extends SaveScannedIngredientsState {}

class SaveScannedIngredientsInProgress extends SaveScannedIngredientsState {}

class SaveScannedIngredientsSuccess extends SaveScannedIngredientsState {
  final String message;

  const SaveScannedIngredientsSuccess({required this.message});
}

class SaveScannedIngredientsFailure extends SaveScannedIngredientsState {
  final String message;

  const SaveScannedIngredientsFailure({required this.message});
}
