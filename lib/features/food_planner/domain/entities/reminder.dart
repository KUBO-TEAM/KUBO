import 'package:equatable/equatable.dart';

class Reminder extends Equatable {
  const Reminder({
    required this.title,
    required this.message,
    this.recipeId,
  });

  final String title;
  final String message;
  final String? recipeId;

  @override
  List<Object?> get props => [
        title,
        message,
        recipeId,
      ];
}
