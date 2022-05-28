import 'package:hive/hive.dart';

part 'category.g.dart';

const kCategoryBoxKey = 'Category Box Key';

@HiveType(typeId: 5)
class Category extends HiveObject {
  Category({
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
  String imageUrl;

  Map<String, dynamic> toMap() => {
        'name': name,
        'accuracy': accuracy,
        'predictedAt': predictedAt.toIso8601String(),
        'imageUrl': imageUrl,
      };
}
