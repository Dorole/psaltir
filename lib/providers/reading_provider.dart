import 'dart:math';
import 'package:psaltir/constants/app_consts.dart';
import 'package:psaltir/models/psalm_loader.dart';

import '../models/reading_models.dart';
import 'package:flutter/material.dart';

class ReadingProvider extends ChangeNotifier {
  final PsalmLoader _psalmLoader;
  final Set<int> _randomSession = {};
  final List<int> _categoryPsalmNumbers = [];
  final Random _rand = Random();

  ReadingChoice? _readingChoice;
  Category? _selectedCategory;
  int? _psalmNumber;
  bool _categoryInOrder = false;
  int _categoryIndex = 0;
  bool _showPsalm = true;

  Future<String>? _detailsFuture;

  bool get showPsalm => _showPsalm;
  bool get hasDetails => _psalmLoader.hasDetails(_psalmNumber!);
  Future<String>? get detailsFuture => _detailsFuture;

  ReadingProvider({required PsalmLoader psalmLoader})
    : _psalmLoader = psalmLoader;

  int _sequentialNext(int current) =>
      (current < AppConsts.psalmCount) ? current + 1 : 1;
  int _sequentialPrevious(int current) =>
      (current > 1) ? current - 1 : AppConsts.psalmCount;
  int _categoryNext(int currentIndex) =>
      (currentIndex + 1) % _categoryPsalmNumbers.length;
  int _categoryPrevious(int currentIndex) =>
      (currentIndex - 1 + _categoryPsalmNumbers.length) %
      _categoryPsalmNumbers.length;

  // #region DEBUG
  ReadingChoice? get readingChoice => _readingChoice;
  Category? get category => _selectedCategory;
  int? get psalmNumber => _psalmNumber;
  // #endregion

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
      _initializeCategory(_selectedCategory!);
    } else {
      _psalmNumber = psalmNumber ?? getRandomPsalm();
    }

    notifyListeners();
  }

  int getRandomPsalm() {
    if (_randomSession.length == AppConsts.psalmCount) {
      _randomSession.clear();
    }

    int newRand;
    do {
      newRand = _rand.nextInt(AppConsts.psalmCount) + 1;
    } while (_randomSession.contains(newRand));

    _randomSession.add(newRand);
    return newRand;
  }

  void goToNextPsalm({required bool forward}) {
    switch (_readingChoice) {
      case ReadingChoice.random:
        _psalmNumber = getRandomPsalm();
        break;
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

  void toggleReadingView() {
    _showPsalm = !_showPsalm;

    if (!showPsalm) {
      _detailsFuture = getCurrentPsalmDetails();
    }

    notifyListeners();
  }

  // ***** PSALM LOADING *****
  Future<String> loadCurrentPsalmText() async {
    return await _psalmLoader.getPsalmByNumber(_psalmNumber!);
  }

  Future<String> getCurrentPsalmDetails() async {
    return await _psalmLoader.getDetails(_psalmNumber!);
  }

  void _initializeCategory(Category category) {
    _categoryPsalmNumbers
      ..clear()
      ..addAll(_psalmLoader.getPsalmsByCategory(category));

    if (!_categoryInOrder) {
      _categoryPsalmNumbers.shuffle();
    }

    _categoryIndex = 0;
    _psalmNumber = _categoryPsalmNumbers.first;
  }
}
