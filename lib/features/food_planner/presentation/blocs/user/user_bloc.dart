import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/usecases/usecase.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';
import 'package:kubo/features/food_planner/domain/usecases/fetch_user.dart';
import 'package:kubo/features/food_planner/domain/usecases/initialize_user.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchUser fetchUser;
  final InitializeUser initializeUser;

  UserBloc({
    required this.fetchUser,
    required this.initializeUser,
  }) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is UserFetched) {
        final failureOrUser = await fetchUser(NoParams());

        await failureOrUser.fold(
          (failure) async {
            final failureOrUserInitialize = await initializeUser(NoParams());

            failureOrUserInitialize.fold((failure) {
              emit(const UserFailure(message: 'User fails'));
            }, (user) {
              emit(UserSuccess(user: user));
            });
          },
          (user) {
            emit(UserSuccess(user: user));
          },
        );
      }
    });
  }
}
