import 'package:flutter/material.dart';

class BookmarksProvider extends ChangeNotifier {
  final Set<int> _bookmarks = {};

  Set<int> get bookmarks => _bookmarks; // uncomment if needed
  bool isBookmarked(int number) => _bookmarks.contains(number);

  void addBookmark(int number) {
    _bookmarks.add(number);
    notifyListeners();

    print("Psalam $number dodan u favorite.");
    print("Favoriti: $_bookmarks");
  }

  void removeBookmark(int number) {
    _bookmarks.remove(number);
    notifyListeners();

    print("Psalam $number izbrisan iz favorita");
    print("Favoriti: $_bookmarks");
  }

  void toggleBookmark(int number) {
    if (isBookmarked(number)) {
      removeBookmark(number);
    } else {
      addBookmark(number);
    }
  }
}
