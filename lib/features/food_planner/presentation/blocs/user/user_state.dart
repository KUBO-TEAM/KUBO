part of 'user_bloc.dart';

abstract class UserState {
  const UserState();
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
