import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/bookmarks_provider.dart';

class BookmarkCard extends StatelessWidget {
  const BookmarkCard({
    super.key,
    required this.themeColors,
    required this.psalmNumber,
    required this.theme,
  });

  final ColorScheme themeColors;
  final int psalmNumber;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final bProvider = context.read<BookmarksProvider>();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      color: themeColors.primary,
      child: AnimatedSize(
        duration: Duration(milliseconds: 200),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Psalam $psalmNumber", style: theme.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                "${bProvider.getPreview(psalmNumber)}",
                textAlign: TextAlign.center,
                style: TextStyle(color: themeColors.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
