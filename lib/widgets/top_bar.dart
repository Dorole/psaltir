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

    Widget action(Widget? a) => SizedBox(
      width: 48,
      height: 48,
      child: Center(child: a ?? const SizedBox.shrink()),
    );
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
      color: themeColors.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          action(leftAction),
          Expanded(
            child: Center(child: Text(title, style: textStyle)),
          ),
          action(rightAction),
        ],
      ),
    );
  }
}
