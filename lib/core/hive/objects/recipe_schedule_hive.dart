import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'recipe_schedule_hive.g.dart';

@HiveType(typeId: 0)
class RecipeScheduleHive extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String imageUrl;

  @HiveField(4)
  DateTime start;

  @HiveField(5)
  DateTime end;

  @HiveField(6)
  Color color;

  RecipeScheduleHive({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.start,
    required this.end,
    required this.color,
  });
}
