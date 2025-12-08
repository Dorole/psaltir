import 'package:flutter/material.dart';
import 'package:psaltir/constants/app_consts.dart';
import 'package:psaltir/models/psalm_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarksProvider extends ChangeNotifier {
  final Set<int> _bookmarks = {};
  final Map<int, String> _previews = {};
  final PsalmLoader _psalmLoader;
  late final SharedPreferences _prefs;
  bool _initialized = false;

  BookmarksProvider(this._psalmLoader);

  bool isBookmarked(int number) => _bookmarks.contains(number);
  String? getPreview(int number) => _previews[number];
  List<int> get bookmarks {
    if (!_initialized) {
      throw StateError("Bookmarks not initialized yet!");
    }
    return _bookmarks.toList();
  }

  Future<void> init() async {
    if (_initialized) return;

    _prefs = await SharedPreferences.getInstance();
    await _loadFromStorage();
    _initialized = true;
  }

  Future<void> addBookmark(int number) async {
    _bookmarks.add(number);

    if (!_previews.containsKey(number)) {
      _previews[number] = await _psalmLoader.loadPsalmPreview(number);
    }

    _saveToStorage();
    notifyListeners();
    //print("Favoriti: $_bookmarks");
  }

  void removeBookmark(int number) {
    _bookmarks.remove(number);
    _previews.remove(number);
    _saveToStorage();
    notifyListeners();

    //print("Favoriti: $_bookmarks");
  }

  void toggleBookmark(int number) {
    if (isBookmarked(number)) {
      removeBookmark(number);
    } else {
      addBookmark(number);
    }
  }

  List<int> getSortedBookmarks() {
    var list = _bookmarks.toList();
    list.sort();
    return list;
  }

  int getPsalmSorted(int index) => getSortedBookmarks()[index];

  // #region SAVE/LOAD
  Future<void> _loadFromStorage() async {
    final list = _prefs.getStringList(AppConsts.bookmarksStorage) ?? [];

    _bookmarks
      ..clear()
      ..addAll(list.map(int.parse));

    for (var num in _bookmarks) {
      _previews[num] = await _psalmLoader.loadPsalmPreview(num);
    }

    notifyListeners();

    //print("Učitani psalmi: $_bookmarks");
  }

  Future<void> _saveToStorage() async {
    await _prefs.setStringList(
      AppConsts.bookmarksStorage,
      _bookmarks.map((e) => e.toString()).toList(),
    );

    // print(
    //   "Spremljeni psalmi: ${_prefs.getStringList(AppConsts.bookmarksStorage)}",
    // );
  }
  // #endregion

  // #region TESTING
  Future<void> clearBookmarks() async {
    _bookmarks.clear();
    _previews.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConsts.bookmarksStorage);
    notifyListeners();
  }

  // #endregion
}
