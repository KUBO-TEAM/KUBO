import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:kubo/core/constants/string_constants.dart';
import 'package:kubo/core/error/exceptions.dart';
import 'package:kubo/features/food_planner/data/models/reminder_model.dart';
import 'package:http/http.dart' as http;
import 'package:kubo/features/food_planner/domain/entities/user.dart';

abstract class ReminderRemoteDataSource {
  /// fetch [ReminderModel] in remote
  ///
  /// Throws [ServerException] if no remote data is present.
  ///
  Future<List<ReminderModel>> fetchReminders(
    User user,
  );
}

@LazySingleton(as: ReminderRemoteDataSource)
class ReminderRemoteDataSourceImpl implements ReminderRemoteDataSource {
  final http.Client client;

  ReminderRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ReminderModel>> fetchReminders(User user) async {
    try {
      final response = await client.get(
        Uri.parse('$kKuboUrl/api/notification'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var body = json.decode(response.body);

        var data = body['data'];

        List<ReminderModel> reminders = [];

        for (var value in data) {
          final reminder = ReminderModel.fromJson(value);

          if (reminder.createdAt.toLocal().isAfter(user.startedAt.toLocal())) {
            reminder.createdAt.toLocal();
            reminders.add(reminder);
          }
        }

        return reminders;
      } else {
        throw ServerException();
      }
    } on Exception {
      throw ServerException();
    }
  }
}
