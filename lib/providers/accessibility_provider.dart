import 'package:flutter/material.dart';
import 'package:psaltir/models/reading_font.dart';
import 'package:psaltir/services/settings_store.dart';

class TextSettingsProvider extends ChangeNotifier {
  TextSettingsProvider(this._store);

  final SettingsStore _store;
  final double _baseTextSize = 18;
  final double _defaultTextScale = 1.0;
  final double _minTextScale = 0.8;
  final double _maxTextScale = 1.6;
  final double _baseLineHeight = 1.4;

  double _readingTextScale = 1.0;
  double _lineHeight = 1.4;
  ReadingFont _readingFont = ReadingFont.literata;

  double get baseTextSize => _baseTextSize;
  double get readingTextScale => _readingTextScale;
  double get minTextScale => _minTextScale;
  double get maxTextScale => _maxTextScale;
  double get baseLineHeight => _baseLineHeight;
  double get lineHeight => _lineHeight;
  double get finalTextSize => _baseTextSize * _readingTextScale;
  ReadingFont get readingFont => _readingFont;

  TextStyle get readingTextStyle => TextStyle(
    fontFamily: readingFont.label,
    fontSize: finalTextSize,
    height: lineHeight,
  );

  void load() {
    _readingTextScale = _store.loadTextScale() ?? _defaultTextScale;
    _lineHeight = _store.loadLineHeight() ?? _baseLineHeight;
    _readingFont = _store.loadReadingFont();

    notifyListeners();
  }

  Future<void> reset() async {
    await _store.removeAll();
    load();
  }

  Future<void> setReadingTextScale(double value) async {
    _readingTextScale = value;
    notifyListeners();

    await _store.saveTextScale(_readingTextScale);
  }

  Future<void> setLineHeight(double value) async {
    _lineHeight = value;
    notifyListeners();

    await _store.saveLineHeight(_lineHeight);
  }

  Future<void> setReadingFont(ReadingFont font) async {
    if (_readingFont == font) return;
    _readingFont = font;
    notifyListeners();

    await _store.saveReadingFont(_readingFont);
  }
}
