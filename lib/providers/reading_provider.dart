import 'dart:math';
import 'package:psaltir/models/psalm_loader.dart';

import '../models/reading_models.dart';
import 'package:flutter/material.dart';

class ReadingProvider extends ChangeNotifier {
  final PsalmLoader psalmLoader;

  ReadingChoice? _readingChoice;
  Category? _selectedCategory;
  int? _psalmNumber;

  bool _categoryInOrder = false;
  List<int>? _categoryPsalmNumbers;
  int _categoryIndex = 0;

  ReadingProvider({required this.psalmLoader});

  int _sequentialNext(int current) => (current < 150) ? current + 1 : 1;
  int _sequentialPrevious(int current) => (current > 1) ? current - 1 : 150;
  int _categoryNext(int currentIndex) =>
      (currentIndex + 1) % _categoryPsalmNumbers!.length;
  int _categoryPrevious(int currentIndex) =>
      (currentIndex - 1 + _categoryPsalmNumbers!.length) %
      _categoryPsalmNumbers!.length;

  // ***** DEBUG *****
  ReadingChoice? get readingChoice => _readingChoice;
  Category? get category => _selectedCategory;
  int? get psalmNumber => _psalmNumber;

  void setReadingOptions({
    ReadingChoice? readingChoice,
    Category? selectedCategory,
    int? psalmNumber,
    bool categoryInOrder = false,
  }) async {
    _readingChoice = readingChoice;
    _selectedCategory = selectedCategory;
    _categoryInOrder = categoryInOrder;

    if (_readingChoice == ReadingChoice.category) {
      await _initializeCategory(_selectedCategory!);
    } else {
      _psalmNumber = psalmNumber ?? getRandomPsalm();
    }

    notifyListeners();
  }

  int getRandomPsalm() {
    return Random().nextInt(150) + 1;
  }

  void goToNextPsalm({required bool forward}) {
    switch (_readingChoice) {
      case ReadingChoice
          .random: //ALTERNATIVE: display random psalm again, disregard direction
      case ReadingChoice.number:
        _psalmNumber = forward
            ? _sequentialNext(_psalmNumber!)
            : _sequentialPrevious(_psalmNumber!);
        break;
      case ReadingChoice.category:
        _categoryIndex = forward
            ? _categoryNext(_categoryIndex)
            : _categoryPrevious(_categoryIndex);
        _psalmNumber = _categoryPsalmNumbers![_categoryIndex];
        break;
      default:
        _psalmNumber = 1;
    }
    notifyListeners();
  }

  // ***** PSALM LOADING *****
  Future<String> loadCurrentPsalmText() async {
    return await psalmLoader.getPsalmByNumber(_psalmNumber!);
  }

  Future<void> _initializeCategory(Category category) async {
    if (_categoryPsalmNumbers!.isNotEmpty){
      _categoryPsalmNumbers!.clear();
    }

    _categoryPsalmNumbers = await psalmLoader.getPsalmsByCategory(category);

    if (!_categoryInOrder) {
      _categoryPsalmNumbers!.shuffle();
    }

    _categoryIndex = 0;
    _psalmNumber = _categoryPsalmNumbers!.first;
  }
}
