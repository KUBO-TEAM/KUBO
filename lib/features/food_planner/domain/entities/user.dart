import 'package:hive/hive.dart';

part 'user.g.dart';

const kUserBoxKey = 'User Box Key';

@HiveType(typeId: 4)
class User extends HiveObject {
  // Notifications
  @HiveField(0)
  int notificationChannelIdCounter;

  @HiveField(1)
  DateTime startedAt;

  @HiveField(2)
  DateTime remindersSeenAt;

  User({
    required this.notificationChannelIdCounter,
    required this.remindersSeenAt,
    required this.startedAt,
  });
}
