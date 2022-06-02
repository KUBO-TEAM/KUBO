import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/core/constants/menu_constants.dart';
import 'package:kubo/features/food_planner/domain/entities/ingredient.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:table_calendar/table_calendar.dart';

const tId = '123';
const tName = 'name';
const tDescription = 'description';
const tDisplayPhoto = 'displayPhoto';
const tDay = 1;

final today = DateTime.now();
final todayWeekday = DateFormat('EEEE').format(today);
final indexTodayWeekDay = kDayList.indexOf(todayWeekday);
final scheduleDay = today.day + (tDay - indexTodayWeekDay);

const tStartTimeOfDay = TimeOfDay(hour: 12, minute: 0);
const tEndTimeOfDay = TimeOfDay(hour: 13, minute: 0);

final tStart = DateTime(
  today.year,
  today.month,
  scheduleDay,
  12,
  0,
);

final tEnd = DateTime(
  today.year,
  today.month,
  scheduleDay,
  13,
  0,
);
const tColor = Colors.white;
const tAllDay = false;

final tRecipeScheduleModel = RecipeSchedule(
  notificationStartId: 1,
  recipe: const Recipe(
    id: tId,
    name: tName,
    description: tDescription,
    course: 'test',
    cuisine: 'test',
    prepTime: 20,
    cookTime: 20,
    servings: 20,
    reference: 'test',
    displayPhoto: 'test',
    categories: ['Talong'],
    ingredients: [Ingredient(name: 'test', quantity: 4)],
    instructions: ['test'],
    createdAt: 'gasdg',
  ),
  start: tStart,
  end: tEnd,
  color: tColor,
  isAllDay: tAllDay,
  createdAt: tStart,
);

final tRecipeSchedule = tRecipeScheduleModel;

final _resources = {
  DateTime.now(): [tRecipeSchedule]
};

final tRecipeScheduleLinkedHashmap =
    LinkedHashMap<DateTime, List<RecipeSchedule>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_resources);

final tRecipeScheduleModelLinkedHashmap =
    LinkedHashMap<DateTime, List<RecipeSchedule>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_resources);
