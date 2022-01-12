import 'package:hive/hive.dart';
part 'schedule.hive.g.dart';

@HiveType(typeId: 0)
class ScheduleHive extends HiveObject {
  @HiveField(0)
  String recipeName;

  @HiveField(1)
  String scheduledDay;

  @HiveField(2)
  String startingTime;

  @HiveField(3)
  String endingTime;

  ScheduleHive({
    required this.recipeName,
    required this.scheduledDay,
    required this.startingTime,
    required this.endingTime,
  });
}
