import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kubo/core/constants/date_time_constants.dart';
import 'package:kubo/core/constants/list_costants.dart';
import 'package:kubo/core/helpers/date_converter.dart';
import 'package:kubo/core/helpers/notification_reminder.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe.dart';
import 'package:kubo/features/food_planner/domain/entities/recipe_schedule.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category.dart';
import 'package:kubo/features/smart_recipe_selection/domain/entities/category_with_quantity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../features/food_planner/domain/entities/user.dart';

class Utils {
  static Future<String> downloadFile(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);

    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static bool isPredictedImageExpired(DateTime date) {
    final expirationDate = date.add(kGlobalVegetablesExpirationDurationDate);

    final isExpired = expirationDate.isBefore(DateTime.now());

    return isExpired;
  }

  static List<CategoryWithQuantity> fixRepeatingCategories(
      List<Category> categories) {
    Map resultedMap = {};

    for (Category category in categories) {
      if (resultedMap.containsKey(category.name)) {
        resultedMap[category.name] = {
          'quantity': resultedMap[category.name]['quantity'] + 1,
          'category': category
        };
      } else {
        resultedMap[category.name] = {
          'quantity': 1,
          'category': category,
        };
      }
    }

    return resultedMap.entries
        .map(
          (entry) => CategoryWithQuantity(
            quantity: entry.value['quantity'],
            category: entry.value['category'],
          ),
        )
        .toList();
  }

  static String toPercentage(double num) {
    final timeHundred = num * 100;
    return '${timeHundred.toStringAsFixed(2)}%';
  }

  static TimeOfDay? dateTimeToTimeOfDay(DateTime? time) {
    if (time == null) {
      return null;
    }

    return TimeOfDay(hour: time.hour, minute: time.minute);
  }

  static String findDay(DateTime startedTime) =>
      DateFormat('EEEE').format(startedTime);

  static DateTime convertStartTimeOfDay({
    required String day,
    required TimeOfDay startTimeOfDay,
  }) {
    final today = DateTime.now();

    final intDay = kDayList.indexOf(day);

    final todayWeekday = DateFormat('EEEE').format(today);
    final indexTodayWeekDay = kDayList.indexOf(todayWeekday);

    int diffIntDayAndTodayWeekday = intDay - indexTodayWeekDay;

    if (diffIntDayAndTodayWeekday < 0) {
      diffIntDayAndTodayWeekday = 7 + diffIntDayAndTodayWeekday;
    }

    final scheduleDay = today.day + diffIntDayAndTodayWeekday;

    return DateTime(
      today.year,
      today.month,
      scheduleDay,
      startTimeOfDay.hour,
      startTimeOfDay.minute,
    );
  }

  static StartAndEndDateTime convertStartAndEndTimeOfDay({
    required String day,
    required TimeOfDay startTimeOfDay,
    required TimeOfDay endTimeOfDay,
  }) {
    final today = DateTime.now();

    final intDay = kDayList.indexOf(day);

    final todayWeekday = DateFormat('EEEE').format(today);
    final indexTodayWeekDay = kDayList.indexOf(todayWeekday);

    int diffIntDayAndTodayWeekday = intDay - indexTodayWeekDay;

    if (diffIntDayAndTodayWeekday < 0) {
      diffIntDayAndTodayWeekday = 7 + diffIntDayAndTodayWeekday;
    }

    final scheduleDay = today.day + diffIntDayAndTodayWeekday;

    final start = DateTime(
      today.year,
      today.month,
      scheduleDay,
      startTimeOfDay.hour,
      startTimeOfDay.minute,
    );

    final end = DateTime(
      today.year,
      today.month,
      scheduleDay,
      endTimeOfDay.hour,
      endTimeOfDay.minute,
    );

    return StartAndEndDateTime(start: start, end: end);
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static int hoursBetween(DateTime from, DateTime to) {
    return to.difference(from).inHours;
  }

  static Future<void> scheduleNotification({
    required RecipeSchedule recipeSchedule,
  }) async {
    _scheduleNotification(
      id: recipeSchedule.notificationStartId,
      startingDate: recipeSchedule.start,
      timeToSubstract: Duration.zero,
      recipe: recipeSchedule.recipe,
      title: 'Upcoming recipe',
      message: 'Your scheduled recipe is ready, please prepare it now.',
    );

    recipeSchedule.notificationStartId++;

    _scheduleNotification(
      id: recipeSchedule.notificationStartId,
      startingDate: recipeSchedule.start,
      timeToSubstract: const Duration(hours: 1),
      recipe: recipeSchedule.recipe,
      title: 'Upcoming recipe',
      message: '1 hour before the latest scheduled recipe.',
    );

    recipeSchedule.notificationStartId++;

    _scheduleNotification(
      id: recipeSchedule.notificationStartId,
      startingDate: recipeSchedule.start,
      timeToSubstract: const Duration(minutes: 30),
      recipe: recipeSchedule.recipe,
      title: 'Upcoming recipe',
      message: '30 minutes before the latest scheduled recipe.',
    );

    recipeSchedule.notificationStartId++;

    _scheduleNotification(
      id: recipeSchedule.notificationStartId,
      startingDate: recipeSchedule.start,
      timeToSubstract: const Duration(minutes: 15),
      recipe: recipeSchedule.recipe,
      title: 'Upcoming recipe',
      message: '15 minutes before the latest scheduled recipe.',
    );
  }

  static Future<void> scheduleNotificationWithUser({
    required DateTime start,
    required Recipe recipe,
    required User user,
  }) async {
    _scheduleNotification(
      id: user.notificationChannelIdCounter,
      startingDate: start,
      timeToSubstract: Duration.zero,
      recipe: recipe,
      title: 'Upcoming recipe',
      message: 'Your scheduled recipe is ready, please prepare it now.',
    );

    user.notificationChannelIdCounter++;

    _scheduleNotification(
      id: user.notificationChannelIdCounter,
      startingDate: start,
      timeToSubstract: const Duration(hours: 1),
      recipe: recipe,
      title: 'Upcoming recipe',
      message: '1 hour before the latest scheduled recipe.',
    );

    user.notificationChannelIdCounter++;

    _scheduleNotification(
      id: user.notificationChannelIdCounter,
      startingDate: start,
      timeToSubstract: const Duration(minutes: 30),
      recipe: recipe,
      title: 'Upcoming recipe',
      message: '30 minutes before the latest scheduled recipe.',
    );

    user.notificationChannelIdCounter++;

    _scheduleNotification(
      id: user.notificationChannelIdCounter,
      startingDate: start,
      timeToSubstract: const Duration(minutes: 15),
      recipe: recipe,
      title: 'Upcoming recipe',
      message: '15 minutes before the latest scheduled recipe.',
    );
    user.notificationChannelIdCounter++;

    await user.save();
  }

  static void _scheduleNotification({
    required int id,
    required DateTime startingDate,
    required Recipe recipe,
    required Duration timeToSubstract,
    required String title,
    required String message,
  }) {
    final defferenceStartingDate = startingDate.subtract(timeToSubstract);

    if (defferenceStartingDate.isAfter(DateTime.now())) {
      NotificationReminder.showScheduledNotification(
        id: id,
        title: title,
        body: message,
        payload: recipe.name,
        largeIconUrl: 'https://kuboph.dev/assets/logo.ico',
        bigPictureUrl: recipe.displayPhoto,
        scheduledDate: defferenceStartingDate,
      );
    }
  }
}
