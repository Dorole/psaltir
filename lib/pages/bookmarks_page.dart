import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/bookmarks_provider.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  // ***** DEBUG VIEW *****
  @override
  Widget build(BuildContext context) {
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
                  final bookmarksList = value.bookmarks.toList();
                  return ListView.builder(
                    itemCount: value.bookmarks.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            title: Text("Psalam ${bookmarksList[index]}"),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_outline_rounded),
                              color: Theme.of(context).colorScheme.onPrimary,
                              onPressed: () =>
                                  value.removeBookmark(bookmarksList[index]),
                            ),
                          ),
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
