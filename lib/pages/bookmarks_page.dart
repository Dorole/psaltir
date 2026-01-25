import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/models/navigation_models.dart';
import 'package:psaltir/models/reading_models.dart';
import 'package:psaltir/providers/bookmarks_provider.dart';
import 'package:psaltir/providers/navigation_provider.dart';
import 'package:psaltir/providers/reading_provider.dart';
import 'package:psaltir/widgets/bookmark_card.dart';
import 'package:psaltir/widgets/top_bar_back_reading.dart';


class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  final String message = "Još nemate omiljenih psalama";

  void _onCardTap(
    ReadingProvider reading,
    NavigationProvider nav,
    int psalmNumber,
  ) {
    reading.setReadingOptions(
      readingChoice: ReadingChoice.number,
      psalmNumber: psalmNumber,
    );

    if (!reading.showPsalm) {
      reading.toggleReadingView();
    }

    nav.openReadingPage();
  }

  // ***** DEBUG VIEW *****
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = theme.colorScheme;

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),

          Expanded(
            child: Consumer<BookmarksProvider>(
              builder: (context, value, child) {
                if (value.bookmarks.isEmpty) {
                  return Center(child: Text(message));
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
                              child:
                                  Consumer2<
                                    ReadingProvider,
                                    NavigationProvider
                                  >(
                                    builder: (_, reading, nav, child) {
                                      return GestureDetector(
                                        child: child!,
                                        onTap: () => _onCardTap(
                                          reading,
                                          nav,
                                          psalmNumber,
                                        ),
                                      );
                                    },
                                    child: BookmarkCard(
                                      themeColors: themeColors,
                                      psalmNumber: psalmNumber,
                                      theme: theme,
                                    ),
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

  Widget _buildHeader() {
    return TopBarBackReading(title: AppPage.bookmarks.label.toUpperCase());
  }
}
