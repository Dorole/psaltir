import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/navigation_provider.dart';
import 'package:psaltir/widgets/top_bar.dart';
import 'package:psaltir/widgets/top_bar_button.dart';

class TopBarBackReading extends StatelessWidget {
  final String title;
  final Widget? rightAction;

  const TopBarBackReading({super.key, required this.title, this.rightAction});

  @override
  Widget build(BuildContext context) {
    final cameFromReading = context.select<NavigationProvider, bool>(
      (nav) => nav.lastReading,
    );

    return TopBar(
      title: title,
      leftAction: cameFromReading ? _backIcon(context) : null,
      rightAction: rightAction,
    );
  }

  Widget _backIcon(BuildContext context) {
    return TopBarButton(
      icon: Icons.arrow_back_rounded,
      onPressed: () {
        context.read<NavigationProvider>().openReadingPage();
      },
    );
  }
}
