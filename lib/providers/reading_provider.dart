import 'dart:math';
import '../models/reading_models.dart';
import 'package:flutter/material.dart';

class ReadingProvider extends ChangeNotifier {
  ReadingChoice? _readingChoice;
  Category? _selectedCategory;
  int? _psalmNumber;
  // ignore: unused_field
  bool _categoryInOrder = false;

  int _sequentialNext(int current) => (current < 150) ? current + 1 : 1;
  int _sequentialPrevious(int current) => (current > 1) ? current - 1 : 150;

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
    _psalmNumber = (psalmNumber != null) ? psalmNumber : getRandomPsalm();
    _categoryInOrder = categoryInOrder;
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
        _psalmNumber = 1; //TO_DO: IMPLEMENT
        break;
      default:
        _psalmNumber = 1;
    }
    notifyListeners();
  }
}
