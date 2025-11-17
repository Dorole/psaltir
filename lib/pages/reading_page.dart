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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("*** READING PAGE ***"),
            const SizedBox(height: 20),

            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // DEBUG
                            "Reading choice: ${readingProvider.readingChoice}",
                          ),
                          Text(
                            "Category: ${readingProvider.category}",
                          ), // DEBUG
                          Text(
                            "Psalm number: ${readingProvider.psalmNumber}",
                          ), // DEBUG
                          const SizedBox(height: 20),
                          Text(
                            // DEBUG
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: SizedBox(
                      width: 60,
                      child: Center(
                        child: IconButton(
                          onPressed: () =>
                              readingProvider.goToNextPsalm(forward: false),
                          icon: Icon(Icons.chevron_left_rounded),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: SizedBox(
                      width: 60,
                      child: Center(
                        child: IconButton(
                          onPressed: () =>
                              readingProvider.goToNextPsalm(forward: true),
                          icon: Icon(Icons.chevron_right_rounded),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
