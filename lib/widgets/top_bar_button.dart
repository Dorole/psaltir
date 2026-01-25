import 'package:flutter/material.dart';

class TopBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool selected;
  final IconData? selectedIcon;

  const TopBarButton({
    required this.icon,
    required this.onPressed,
    this.selected = false,
    this.selectedIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSecondary;

    return IconButton(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      padding: EdgeInsets.zero,
      isSelected: selected,
      icon: Icon(selected ? (selectedIcon ?? icon) : icon),
      iconSize: 30,
      color: color,
      onPressed: onPressed,
    );
  }
}
