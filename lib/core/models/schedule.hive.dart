import 'package:hive/hive.dart';
part 'schedule.hive.g.dart';

@HiveType(typeId: 0)
class ScheduleHive extends HiveObject {
  @HiveField(0)
  final String recipeName;

  @HiveField(1)
  final String scheduledDay;

  @HiveField(2)
  final String startingTime;

  @HiveField(3)
  final String endingTime;

  ScheduleHive({
    required this.recipeName,
    required this.scheduledDay,
    required this.startingTime,
    required this.endingTime,
  });
}
