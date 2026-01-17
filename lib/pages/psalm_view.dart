import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/reading_provider.dart';
import 'package:psaltir/widgets/psalm_text.dart';

class PsalmView extends StatelessWidget {
  const PsalmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }

  Widget _buildNavigationIcon({bool forward = true}) {
    final Icon icon = forward
        ? Icon(Icons.chevron_right_rounded)
        : Icon(Icons.chevron_left_rounded);

    return Consumer<ReadingProvider>(
      builder: (context, reading, child) {
        return IconButton(
          onPressed: () => reading.goToNextPsalm(forward: forward),
          icon: icon,
        );
      },
    );
  }
}
