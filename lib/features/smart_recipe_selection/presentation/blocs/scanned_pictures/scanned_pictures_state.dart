part of 'scanned_pictures_bloc.dart';

abstract class ScannedPicturesState extends Equatable {
  const ScannedPicturesState();

  @override
  List<Object> get props => [];
}

class ScannedPicturesInitial extends ScannedPicturesState {}

class ScannedPicturesInProgress extends ScannedPicturesState {}

class ScannedPicturesSuccess extends ScannedPicturesState {
  final List<String> pictures;

  const ScannedPicturesSuccess({required this.pictures});
}

class ScannedPicturesFailure extends ScannedPicturesState {
  final String message;

  const ScannedPicturesFailure({required this.message});
}
