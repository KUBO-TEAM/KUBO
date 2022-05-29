part of 'your_status_bloc.dart';

abstract class YourStatusEvent extends Equatable {
  const YourStatusEvent();

  @override
  List<Object> get props => [];
}

class YourStatusFetched extends YourStatusEvent {}
