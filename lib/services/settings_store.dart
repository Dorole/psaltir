import 'package:flutter/material.dart';
import 'package:psaltir/models/reading_font.dart';
import 'package:psaltir/services/app_prefs.dart';

class SettingsStore {
  SettingsStore(this.prefs);
  final AppPrefs prefs;

  static const _kThemeMode = "themeMode";
  static const _kTextScale = "readingTextScale";
  static const _kLineHeight = "lineHeight";
  static const _kReadingFont = "readingFont";

  // #region THEME
  Future<void> saveThemeMode(ThemeMode mode) async {
    await prefs.setString(_kThemeMode, mode.name);
  }

  ThemeMode loadThemeMode() {
    final loadedTheme = prefs.getString(_kThemeMode) ?? ThemeMode.system.name;
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == loadedTheme,
      orElse: () => ThemeMode.system,
    );
  }
  // #endregion

  // #region TEXT
  Future<void> saveTextScale(double scale) =>
      prefs.setDouble(_kTextScale, scale);
  double? loadTextScale() => prefs.getDouble(_kTextScale);

  Future<void> saveLineHeight(double height) =>
      prefs.setDouble(_kLineHeight, height);
  double? loadLineHeight() => prefs.getDouble(_kLineHeight);

  Future<void> saveReadingFont(ReadingFont font) =>
      prefs.setString(_kReadingFont, font.name);

  ReadingFont loadReadingFont() {
    final fontName = prefs.getString(_kReadingFont);
    return ReadingFont.values.firstWhere(
      (font) => font.name == fontName,
      orElse: () => ReadingFont.literata,
    );
  }
  // #endregion

  Future<void> removeAll() async {
    await prefs.remove(_kTextScale);
    await prefs.remove(_kLineHeight);
    await prefs.remove(_kReadingFont);
    //await prefs.remove(_kThemeMode);
  }
}
