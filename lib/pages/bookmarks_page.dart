import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/bookmarks_provider.dart';
import 'package:psaltir/widgets/bookmark_card.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  // ***** DEBUG VIEW *****
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = theme.colorScheme;

    return Scaffold(
      body: Column(
        children: [
          const Text("*** BOOKMARKS PAGE ***"),
          const SizedBox(height: 20),

          Expanded(
            child: Consumer<BookmarksProvider>(
              builder: (context, value, child) {
                if (value.bookmarks.isEmpty) {
                  return Center(child: Text("Još nemate omiljenih psalama"));
                } else {
                  return ListView.builder(
                    itemCount: value.bookmarks.length,
                    itemBuilder: (context, index) {
                      final psalmNumber = value.getPsalmSorted(index);
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: BookmarkCard(
                                themeColors: themeColors,
                                psalmNumber: psalmNumber,
                                theme: theme,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.delete_outline_rounded),
                                color: themeColors.secondary,
                                onPressed: () =>
                                    value.removeBookmark(psalmNumber),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
