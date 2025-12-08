import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/pages/psalm_view.dart';
import 'package:psaltir/providers/bookmarks_provider.dart';
import 'package:psaltir/providers/reading_provider.dart';
import 'package:psaltir/widgets/top_bar.dart';
import 'package:psaltir/widgets/top_bar_button.dart';
import 'details_view.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          Consumer<ReadingProvider>(
            builder: (_, reading, _) {
              return reading.showPsalm ? PsalmView() : DetailsView();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ***** WIDGETS *****
  Widget _buildHeader() {
    return Consumer<ReadingProvider>(
      builder: (context, reading, _) {
        final currentPsalm = reading.psalmNumber!;
        return TopBar(
          title: "PSALAM $currentPsalm",
          rightAction: _bookmarksIcon(currentPsalm),
          leftAction: reading.hasDetails
              ? TopBarButton(
                  icon: reading.showPsalm
                      ? Icons.info_outline
                      : Icons.arrow_back,
                  onPressed: reading.toggleReadingView,
                )
              : null, //ili neki placeholder TopBarButton?
        );
      },
    );
  }

  Widget _bookmarksIcon(int currentPsalm) {
    return Consumer<BookmarksProvider>(
      builder: (context, bookmarks, _) {
        return TopBarButton(
          selected: bookmarks.isBookmarked(currentPsalm),
          icon: Icons.bookmark_outline_rounded,
          selectedIcon: Icons.bookmark_rounded,
          onPressed: () => bookmarks.toggleBookmark(currentPsalm),
        );
      },
    );
  }

  // ***** DEBUG *****
  // ignore: unused_element
  Widget _debugInfo(ReadingProvider readingProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Reading choice: ${readingProvider.readingChoice}"),
        Text("Category: ${readingProvider.category}"),
        Text("Psalm number: ${readingProvider.psalmNumber}"),
        const SizedBox(height: 20),
      ],
    );
  }
}
