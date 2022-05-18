import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

const kCategoryBoxKey = 'Category Box Key';

@HiveType(typeId: 5)
class Category extends Equatable {
  const Category({
    required this.name,
    required this.accuracy,
    required this.predictedAt,
    required this.imageUrl,
  });

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double accuracy;

  @HiveField(3)
  final DateTime predictedAt;

  @HiveField(4)
  final String imageUrl;

  @override
  List<Object?> get props => [
        name,
        predictedAt,
        imageUrl,
      ];
}
