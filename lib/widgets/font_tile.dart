import 'package:flutter/material.dart';
import 'package:psaltir/models/reading_font.dart';

class FontTile extends StatelessWidget {
  final ReadingFont font;
  final bool selected;
  final VoidCallback onTap;

  const FontTile({
    super.key,
    required this.font,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                "Aa",
                style: TextStyle(fontFamily: font.fontFamily, fontSize: 32),
              ),
              const SizedBox(height: 6),
              Text(font.label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
