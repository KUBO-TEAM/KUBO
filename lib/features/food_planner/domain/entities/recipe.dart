import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  const Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String description;
  final String imageUrl;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
      ];
}
