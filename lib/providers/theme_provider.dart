import 'package:flutter/material.dart';
import 'package:psaltir/services/settings_store.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this._store);

  final SettingsStore _store;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  bool get isSystem => _themeMode == ThemeMode.system;
  bool get isLight => _themeMode == ThemeMode.light;
  bool get isDark => _themeMode == ThemeMode.dark;

  void load() {
    _themeMode = _store.loadThemeMode();
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    await _store.saveThemeMode(_themeMode);
  }

  Future<void> _setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return Future.value();

    _themeMode = mode;
    notifyListeners();
    _saveTheme();
    return Future.value();
  }

  Future<void> setSystemTheme() => _setThemeMode(ThemeMode.system);
  Future<void> setLightTheme() => _setThemeMode(ThemeMode.light);
  Future<void> setDarkTheme() => _setThemeMode(ThemeMode.dark);
}
