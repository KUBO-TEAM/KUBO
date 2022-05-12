import 'package:equatable/equatable.dart';

class Reminder extends Equatable {
  const Reminder({
    this.recipeId,
    required this.title,
    required this.message,
    required this.createdAt,
  });

  final String title;
  final String message;

  // Optional if a reminder mention a recipe
  final String? recipeId;

  final DateTime createdAt;

  @override
  List<Object?> get props => [
        title,
        message,
        recipeId,
        createdAt,
      ];
}
