import 'package:flutter/material.dart';
import 'package:kubo/features/food_planner/data/models/recipe_schedule_model.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';

const tId = '123';
const tName = 'name';
const tDescription = 'description';
const tImageUrl = 'imageUrl';
final tStart = DateTime.now();
final tEnd = DateTime.now().add(const Duration(hours: 1));
final tColor = Colors.white;
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

final tRecipeSchedule = tRecipeScheduleModel;
