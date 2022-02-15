import 'package:flutter/material.dart';
import 'package:kubo/core/hive/objects/recipe_schedule_hive.dart';
import 'package:kubo/features/food_planner/data/models/recipe_schedule_model.dart';

const tId = '123';
const tName = 'name';
const tDescription = 'description';
const tImageUrl = 'imageUrl';
const tDay = 1;

final dateTimeNow = DateTime.now();
const tStartTimeOfDay = TimeOfDay(hour: 12, minute: 0);
const tEndTimeOfDay = TimeOfDay(hour: 13, minute: 0);

final tStart = DateTime(
  dateTimeNow.year,
  dateTimeNow.month,
  dateTimeNow.day,
  12,
  0,
);

final tEnd = DateTime(
  dateTimeNow.year,
  dateTimeNow.month,
  dateTimeNow.day,
  13,
  0,
);
const tColor = Colors.white;
const tAllDay = false;

final tRecipeScheduleModel = RecipeScheduleModel(
  id: tId,
  name: tName,
  description: tDescription,
  imageUrl: tImageUrl,
  start: tStart,
  end: tEnd,
  color: tColor,
  isAllDay: tAllDay,
);

final tRecipeScheduleHive = RecipeScheduleHive(
  id: tId,
  name: tName,
  description: tDescription,
  imageUrl: tImageUrl,
  start: tStart,
  end: tEnd,
  color: tColor,
);

final tRecipeSchedule = tRecipeScheduleModel;
