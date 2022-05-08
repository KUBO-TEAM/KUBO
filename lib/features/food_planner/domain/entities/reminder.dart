import 'package:equatable/equatable.dart';

class Reminder extends Equatable {
  final String title;
  final String subTitle;
  final String message;

  const Reminder({
    required this.title,
    required this.subTitle,
    required this.message,
  });

  @override
  List<Object?> get props => [
        title,
        subTitle,
        message,
      ];
}
