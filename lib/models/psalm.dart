import 'package:psaltir/models/reading_models.dart';

class Psalm {
  final int number;
  final String file;
  final List<Category> tags;

  Psalm({required this.number, required this.file, required this.tags});

  Psalm.fromJson(Map<String, dynamic> jsonItem)
    : number = jsonItem['number'] as int,
      file = jsonItem['file'] as String,
      tags = (jsonItem['tags'] as List)
          .map((tag) => Category.fromString(tag))
          .whereType<Category>()
          .toList();
}
