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
  bool _categoryInOrder = false;
  int _categoryIndex = 0;
  bool _showPsalm = true;
  late int _psalmNumber;
  late int _nextPsalmNumber;
  late int _prevPsalmNumber;
  late Future<String> _currentPsalmText;
  late Future<String> _nextPsalmText;
  late Future<String> _prevPsalmText;
  Future<String>? _detailsFuture;
  bool _initialized = false;

  ReadingChoice? get readingChoice => _readingChoice;
  Category? get category => _selectedCategory;
  bool get showPsalm => _showPsalm;
  bool get hasDetails => _psalmLoader.hasDetails(_psalmNumber!);
  int get psalmNumber => _psalmNumber;
  int get nextPsalmNumber => _nextPsalmNumber;
  int get prevPsalmNumber => _prevPsalmNumber;
  Future<String> get currentPsalmText => _currentPsalmText;
  Future<String> get nextPsalmText => _nextPsalmText;
  Future<String> get prevPsalmText => _prevPsalmText;
  Future<String>? get detailsFuture => _detailsFuture;
  bool get isReady => _initialized;

  ReadingProvider(this._psalmLoader);

  int _sequentialNext(int current) =>
      (current < AppConsts.psalmCount) ? current + 1 : 1;
  int _sequentialPrevious(int current) =>
      (current > 1) ? current - 1 : AppConsts.psalmCount;
  int _categoryNext(int currentIndex) =>
      (currentIndex + 1) % _categoryPsalmNumbers.length;
  int _categoryPrevious(int currentIndex) =>
      (currentIndex - 1 + _categoryPsalmNumbers.length) %
      _categoryPsalmNumbers.length;

  Future<void> setReadingOptions({
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

    _currentPsalmText = loadCurrentPsalmText();
    _prepareNeighbours();
    _initialized = true;
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

  int _computeCandidate({required bool forward}) {
    switch (_readingChoice) {
      case ReadingChoice.random:
        return getRandomPsalm();

      case ReadingChoice.number:
        return forward
            ? _sequentialNext(_psalmNumber!)
            : _sequentialPrevious(_psalmNumber!);

      case ReadingChoice.category:
        final candidateIdx = forward
            ? _categoryNext(_categoryIndex)
            : _categoryPrevious(_categoryIndex);
        return _categoryPsalmNumbers[candidateIdx];

      default:
        return 1;
    }
  }

  void _prepareNeighbours() {
    _prevPsalmNumber = _computeCandidate(forward: false);
    _nextPsalmNumber = _computeCandidate(forward: true);

    _prevPsalmText = _psalmLoader.getPsalmByNumber(_prevPsalmNumber!);
    _nextPsalmText = _psalmLoader.getPsalmByNumber(_nextPsalmNumber!);
  }

  void commitCandidate({required bool forward, bool notify = true}) {
    _psalmNumber = forward ? _nextPsalmNumber : _prevPsalmNumber;
    _currentPsalmText = loadCurrentPsalmText();

    if (_readingChoice == ReadingChoice.category) {
      _categoryIndex = forward
          ? _categoryNext(_categoryIndex)
          : _categoryPrevious(_categoryIndex);
    }

    _prepareNeighbours();
    if (notify) notifyListeners();
  }

  void notify() => notifyListeners();

  void toggleReadingView() {
    _showPsalm = !_showPsalm;

    if (!showPsalm) {
      _detailsFuture = getCurrentPsalmDetails();
    }

    notifyListeners();
  }

  // #region PSALM LOADING
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

  // #endregion
}
