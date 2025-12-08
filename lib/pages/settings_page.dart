import 'package:flutter/material.dart';
import 'package:psaltir/models/navigation_models.dart';
import 'package:psaltir/widgets/top_bar.dart';
import 'package:psaltir/widgets/top_bar_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [_buildHeader()]));
  }

  Widget _buildHeader() {
    return TopBar(
      title: AppPage.settings.label.toUpperCase(),
      leftAction: _backIcon(),
    );
  }

  // TODO: RETURN TO READING IF CAME FROM READING
  Widget _backIcon() {
    return TopBarButton(icon: Icons.arrow_back_rounded, onPressed: () {});
  }
}
