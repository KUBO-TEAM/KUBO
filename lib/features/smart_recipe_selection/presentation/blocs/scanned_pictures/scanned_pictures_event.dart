part of 'scanned_pictures_bloc.dart';

abstract class ScannedPicturesEvent extends Equatable {
  const ScannedPicturesEvent();

  @override
  List<Object> get props => [];
}

class ScannedPicturesSaved extends ScannedPicturesEvent {
  final String imagePath;

  const ScannedPicturesSaved({required this.imagePath});
}
