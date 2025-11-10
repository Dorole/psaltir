import 'dart:math';
import '../models/reading_models.dart';
import 'package:flutter/material.dart';

class ReadingProvider extends ChangeNotifier {
  ReadingChoice? _readingChoice;
  Category? _selectedCategory;
  int? _psalmNumber;
  bool _categoryInOrder = false;

  // ***** DEBUG *****
  ReadingChoice? get readingChoice => _readingChoice;
  Category? get category => _selectedCategory;
  int? get psalmNumber => _psalmNumber;

  void setReadingOptions({
    ReadingChoice? readingChoice,
    Category? selectedCategory,
    int? psalmNumber,
    bool categoryInOrder = false,
  }) {
    _readingChoice = readingChoice;
    _selectedCategory = selectedCategory;
    _psalmNumber = psalmNumber;
    _categoryInOrder = categoryInOrder;
    notifyListeners();
  }

  int getNextPsalm() {
    switch (_readingChoice) {
      case ReadingChoice.random:
        return Random().nextInt(150) +
            1; //treba pospremiti psalme iz iste sesije
      case ReadingChoice.number:
        // if the user is currently on psalm 150 and presses next --> go to Ps 1
        return (_psalmNumber! < 150) ? _psalmNumber! + 1 : 1;
      case ReadingChoice.category:
        return 1; //TO_DO: IMPLEMENTIRATI OVO
      default:
        return 1;
    }
  }

  void goToNextPsalm() {
    _psalmNumber = getNextPsalm();
    notifyListeners();
  }
}
