part of 'scanned_pictures_list_bloc.dart';

abstract class ScannedPicturesListEvent extends Equatable {
  const ScannedPicturesListEvent();

  @override
  List<Object> get props => [];
}

class ScannedPicturesListFetched extends ScannedPicturesListEvent {}
