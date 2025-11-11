import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/reading_provider.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final readingProvider = context.watch<ReadingProvider>();

    // ***** DEBUG VIEW *****
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("*** READING PAGE ***"),
          const SizedBox(height: 20),
          Text("Reading choice: ${readingProvider.readingChoice}"),
          Text("Category: ${readingProvider.category}"),
          Text("Psalm number: ${readingProvider.psalmNumber}"),
        ],
      ),
    );
  }
}
