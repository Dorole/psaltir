import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/bookmarks_provider.dart';
import 'package:psaltir/providers/reading_provider.dart';
import 'package:psaltir/widgets/psalm_text.dart';
import 'package:psaltir/widgets/top_bar.dart';
import 'package:psaltir/widgets/top_bar_button.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ***** DEBUG VIEW *****

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),

          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: SingleChildScrollView(child: PsalmText()),
                ),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: SizedBox(
                    width: 60,
                    child: Center(child: _buildNavigationIcon(forward: false)),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: SizedBox(
                    width: 60,
                    child: Center(child: _buildNavigationIcon()),
                  ),
                ),
              ],
            ),
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
          leftAction: _infoIcon(),
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

  // TODO: Go to details page if there is one for current psalm
  Widget _infoIcon() {
    return TopBarButton(icon: Icons.info_outline, onPressed: () {});
  }

  Widget _buildNavigationIcon({bool forward = true}) {
    final Icon icon = forward
        ? Icon(Icons.chevron_right_rounded)
        : Icon(Icons.chevron_left_rounded);

    return Consumer<ReadingProvider>(
      builder: (context, value, child) {
        return IconButton(
          onPressed: () => value.goToNextPsalm(forward: forward),
          icon: icon,
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
