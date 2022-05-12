part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserInProgress extends UserState {}

class UserSuccess extends UserState {
  final User user;

  const UserSuccess({
    required this.user,
  });
}

class UserFailure extends UserState {
  final String message;

  const UserFailure({
    required this.message,
  });
}
