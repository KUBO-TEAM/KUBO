import 'package:hive/hive.dart';

part 'user.g.dart';

const kUserBoxKey = 'User Box Key';

@HiveType(typeId: 4)
class User extends HiveObject {
  // Notifications
  @HiveField(0)
  int notificationChannelIdCounter;

  @HiveField(1)
  int unreadNotificationCount;

  //Others
  @HiveField(2)
  DateTime startedAt;

  User({
    required this.notificationChannelIdCounter,
    required this.unreadNotificationCount,
    required this.startedAt,
  });
}
