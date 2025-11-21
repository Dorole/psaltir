import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/reading_provider.dart';

class PsalmText extends StatefulWidget {
  const PsalmText({super.key});

  @override
  State<PsalmText> createState() => _PsalmTextState();
}

class _PsalmTextState extends State<PsalmText> {
  Future<String>? _currentPsalmText;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final readingProvider = context.watch<ReadingProvider>();
    _currentPsalmText = Future.microtask(() => readingProvider.loadCurrentPsalmText());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _currentPsalmText,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
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
