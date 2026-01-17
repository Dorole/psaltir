import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/reading_provider.dart';

class PsalmText extends StatelessWidget {
  const PsalmText({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPsalmText = context.watch<ReadingProvider>().currentPsalmText;
    if (currentPsalmText == null) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<String>(
      future: currentPsalmText,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }
        if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
            style: const TextStyle(color: Colors.red),
          );
        }
        return Text(snapshot.data!);
      },
    );
  }
}
