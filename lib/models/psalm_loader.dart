import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:psaltir/constants/paths_consts.dart';
import 'package:psaltir/models/psalm.dart';
import 'package:psaltir/models/reading_models.dart';

class PsalmLoader {
  List<Psalm>? _metaData;

  // TODO: see how - metaData could be loaded only once,
  // when the user opens the app for the first time?
  Future<List<Psalm>> _loadMetaData() async {
    if (_metaData != null) return _metaData!;

    final jsonString = await rootBundle.loadString(PathsConsts.metadataPath);
    final List<dynamic> data = jsonDecode(jsonString);

    _metaData = data
        .map((jsonItem) => Psalm.fromJson(jsonItem as Map<String, dynamic>))
        .toList();

    return _metaData!;
  }

  Future<String> getPsalmByNumber(int number) async {
    final meta = await _loadMetaData();
    final match = meta.firstWhere((psalm) => psalm.number == number);
    try {
      return await rootBundle.loadString(PathsConsts.psalmPath(match.file));
    } catch (e, st) {
      assert(() {
        print("TEXT ERROR: $e");
        print(st);
        return true;
      }());

      throw PsalmLoadException("Could not load psalm file: ${match.file}");
    }
  }

  Future<List<int>> getPsalmsByCategory(Category category) async {
    final meta = await _loadMetaData();
    final matches = meta
        .where((psalm) => psalm.tags.contains(category))
        .map((psalm) => psalm.number)
        .toList();

    matches.sort();
    return matches;
  }
}

class PsalmLoadException implements Exception {
  final String message;
  PsalmLoadException(this.message);

  @override
  String toString() => message;
}
