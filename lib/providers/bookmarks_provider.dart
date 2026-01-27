import 'package:flutter/material.dart';
import 'package:psaltir/services/bookmarks_store.dart';
import 'package:psaltir/services/psalm_loader.dart';

class BookmarksProvider extends ChangeNotifier {
  BookmarksProvider(this._store, this._psalmLoader);

  final BookmarksStore _store;
  final PsalmLoader _psalmLoader;

  final Set<int> _bookmarks = {};
  final Map<int, String> _previews = {};
  bool _initialized = false;

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
    await _load();
    _initialized = true;
  }

  Future<void> addBookmark(int number) async {
    _bookmarks.add(number);

    if (!_previews.containsKey(number)) {
      _previews[number] = await _psalmLoader.loadPsalmPreview(number);
    }

    notifyListeners();
    await _save();
    //print("Favoriti: $_bookmarks");
  }

  Future<void> removeBookmark(int number) async {
    _bookmarks.remove(number);
    _previews.remove(number);
    notifyListeners();
    await _save();

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
  Future<void> _load() async {
    final loaded = _store.loadBookmarks();

    _bookmarks
      ..clear()
      ..addAll(loaded);

    for (var num in _bookmarks) {
      _previews[num] = await _psalmLoader.loadPsalmPreview(num);
    }

    notifyListeners();

    //print("Učitani psalmi: $_bookmarks");
  }

  Future<void> _save() => _store.saveBookmarks(_bookmarks);
  // #endregion

  // #region TESTING
  Future<void> clearBookmarks() async {
    _bookmarks.clear();
    _previews.clear();
    notifyListeners();

    await _store.clearBookmarks();
  }

  // #endregion
}
