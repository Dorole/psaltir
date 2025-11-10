import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/reading_provider.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final readingProvider = context.watch<ReadingProvider>();

    return Scaffold(
      body: Column(
        children: [
          Text("*** READING PAGE ***"),
          Text("Reading choice: ${readingProvider.readingChoice}"),
          Text("Category: ${readingProvider.category}"),
          Text("Psalm number: ${readingProvider.psalmNumber}"),
        ],
      ),
    );
  }
}
