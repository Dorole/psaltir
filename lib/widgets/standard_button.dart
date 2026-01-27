import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  const StandardButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.borderColor,
    this.borderWidth = 2,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: borderColor, width: borderWidth),
            ),
          ),
          child: Padding(padding: const EdgeInsets.all(6), child: child),
        ),
      ],
    );
  }
}
