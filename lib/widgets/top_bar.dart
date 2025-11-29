import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final Widget? leftAction;
  final Widget? rightAction;

  const TopBar({
    required this.title,
    this.leftAction,
    this.rightAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeColors = theme.colorScheme;
    final textStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSecondary,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
      color: themeColors.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftAction ?? const SizedBox(width: 30),
          Expanded(
            child: Center(child: Text(title, style: textStyle)),
          ),
          rightAction ?? const SizedBox(width: 30),
        ],
      ),
    );
  }
}
