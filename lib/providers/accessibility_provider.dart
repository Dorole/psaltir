import 'package:flutter/material.dart';
import 'package:psaltir/models/reading_font.dart';

class AccessibilityProvider extends ChangeNotifier {
  double _readingTextScale = 1.0;
  double _lineHeight = 1.4; //uskladi sa settings page
  ReadingFont _readingFont = ReadingFont.literata;

  double get readingTextScale => _readingTextScale;
  double get lineHeight => _lineHeight;
  ReadingFont get readingFont => _readingFont;

  void setReadingTextScale(double value) {
    _readingTextScale = value;
    notifyListeners();
  }

  void setLineHeight(double value) {
    _lineHeight = value;
    notifyListeners();
  }

  void setReadingFont(ReadingFont font) {
    if (_readingFont == font) return;
    _readingFont = font;
    notifyListeners();
  }
}
