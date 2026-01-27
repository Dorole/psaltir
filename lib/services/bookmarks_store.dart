import 'package:psaltir/services/app_prefs.dart';

class BookmarksStore {
  BookmarksStore(this.prefs);
  final AppPrefs prefs;

  static const _kBookmarks = "bookmarks";

  Future<void> saveBookmarks(Set<int> bookmarks) async {
    final List<String> list = bookmarks.map((e) => e.toString()).toList();
    await prefs.setStringList(_kBookmarks, list);
  }

  Set<int> loadBookmarks() {
    final List<String> list = prefs.getStringList(_kBookmarks) ?? const [];

    final Set<int> result = <int>{};
    for (final s in list) {
      final int? n = int.tryParse(s);
      if (n != null) result.add(n);
    }
    return result;
  }

  Future<void> clearBookmarks() async {
    await prefs.remove(_kBookmarks);
  }
}
