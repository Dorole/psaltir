import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:psaltir/constants/paths_consts.dart';
import 'package:psaltir/models/psalm.dart';
import 'package:psaltir/models/reading_models.dart';

class PsalmLoader {
  List<Psalm>? _metaData;

  Future<void> preloadData() async {
    if (_metaData != null) return;

    final jsonString = await rootBundle.loadString(PathsConsts.metadataPath);
    final List<dynamic> data = jsonDecode(jsonString);

    _metaData = data
        .map((jsonItem) => Psalm.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
  }

  Psalm _getPsalmMetadata(int number) {
    if (_metaData == null) {
      throw StateError("PsalmLoader.preloadData() must be called before use!");
    }
    return _metaData!.firstWhere((p) => p.number == number);
  }

  Future<String> getPsalmByNumber(int number) async {
    final match = _getPsalmMetadata(number);
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

  List<int> getPsalmsByCategory(Category category) {
    if (_metaData == null) {
      throw StateError("PsalmLoader.preloadData() must be called before use!");
    }

    final matches = _metaData!
        .where((psalm) => psalm.tags.contains(category))
        .map((psalm) => psalm.number)
        .toList();

    matches.sort();
    return matches;
  }

  bool hasDetails(int number) {
    return _getPsalmMetadata(number).hasDetails;
  }

  Future<String> getDetails(int number) async {
    final match = _getPsalmMetadata(number);

    if (!match.hasDetails) {
      return "No details available. This page shouldn't even be accessible.";
    }
    return await rootBundle.loadString(PathsConsts.detailsPath(match.file));
  }

  Future<String> loadPsalmPreview(int number, {int maxChars = 100}) async {
    final fullText = await getPsalmByNumber(number);

    final lines = fullText
        .split("\n")
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    if (lines.isEmpty) return "";

    String preview;
    if (lines.length >= 2) {
      preview = "${lines[0]}\n${lines[1]}";
    } else {
      preview = lines[0];
    }

    if (preview.endsWith(",") || preview.endsWith(":")) {
      preview = preview.substring(0, preview.length - 1);
    }

    if (preview.length > maxChars) {
      preview = preview.substring(0, maxChars).trimRight();
      return "$preview...";
    }

    return preview;
  }
}

class PsalmLoadException implements Exception {
  final String message;
  PsalmLoadException(this.message);

  @override
  String toString() => message;
}
