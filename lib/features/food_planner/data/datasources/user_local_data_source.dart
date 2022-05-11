import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/features/food_planner/domain/entities/user.dart';

abstract class UserLocalDataSource {
  /// create [UserModel] to the cached.
  ///
  /// Throws [CacheException] if data is not save.
  ///
  Future<User> fetchUser();

  Future<User> initializeUser();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box<User> userBox;

  UserLocalDataSourceImpl({required this.userBox});

  @override
  Future<User> fetchUser() async {
    User? user = userBox.get(0);

    if (user == null) {
      throw CacheException();
    }

    return user;
  }

  @override
  Future<User> initializeUser() async {
    await userBox.deleteAll(userBox.keys);

    User user = User(
      notificationChannelIdCounter: 0,
      unreadNotificationCount: 0,
      startedAt: DateTime.now(),
    );
    await userBox.add(user);

    return user;
  }
}
