import 'package:flutter/material.dart';
import 'package:psaltir/models/psalm_loader.dart';

class BookmarksProvider extends ChangeNotifier {
  final Set<int> _bookmarks = {};
  final Map<int, String> _previews = {};
  final PsalmLoader _psalmLoader;

  BookmarksProvider({required PsalmLoader psalmLoader})
    : _psalmLoader = psalmLoader;

  bool isBookmarked(int number) => _bookmarks.contains(number);
  List<int> get bookmarks => _bookmarks.toList();
  String? getPreview(int number) => _previews[number];

  Future<void> addBookmark(int number) async {
    _bookmarks.add(number);

    if (!_previews.containsKey(number)) {
      _previews[number] = await _psalmLoader.loadPsalmPreview(number);
    }

    notifyListeners();
    //print("Favoriti: $_bookmarks");
  }

  void removeBookmark(int number) {
    _bookmarks.remove(number);
    _previews.remove(number);
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
}
