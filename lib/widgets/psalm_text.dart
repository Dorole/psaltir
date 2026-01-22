import 'package:flutter/material.dart';

class PsalmText extends StatefulWidget {
  final Future<String> text;
  const PsalmText({super.key, required this.text});

  @override
  State<PsalmText> createState() => _PsalmTextState();
}

class _PsalmTextState extends State<PsalmText> {
  String? _lastText;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: widget.text,
      initialData: _lastText,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
            style: const TextStyle(color: Colors.red),
          );
        }
        final data = snapshot.data;

        if (snapshot.connectionState == ConnectionState.done && data != null) {
          _lastText = data;
        }

        return Text(data ?? "");
      },
    );
  }
}
