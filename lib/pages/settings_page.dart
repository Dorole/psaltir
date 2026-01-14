import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/models/navigation_models.dart';
import 'package:psaltir/models/reading_font.dart';
import 'package:psaltir/providers/accessibility_provider.dart';
import 'package:psaltir/widgets/font_tile.dart';
import 'package:psaltir/widgets/top_bar.dart';
import 'package:psaltir/widgets/top_bar_button.dart';

// podijeli u sekcije: Accessibility section, Theme section, Import/Export (service), About section

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  final double _baseTextSize = 18; //move to app consts?
  final double _minScale = 0.8;
  final double _maxScale = 1.6;

  final double _baseLineHeight = 1.4; //ovo se postavlja i u accessibility??
  final double _lineHeightStep = 0.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Veličina teksta psalma",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    "A",
                    style: TextStyle(fontSize: _baseTextSize * _minScale),
                  ),
                  Consumer<AccessibilityProvider>(
                    builder: (_, accessibility, _) {
                      return Slider(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        value: accessibility.readingTextScale,
                        min: _minScale,
                        max: _maxScale,
                        divisions: 8,
                        onChanged: accessibility.setReadingTextScale,
                      );
                    },
                  ),
                  Text(
                    "A",
                    style: TextStyle(fontSize: _baseTextSize * _maxScale),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Visina proreda",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.remove),
                  Consumer<AccessibilityProvider>(
                    builder: (_, accessibility, _) {
                      return Slider(
                        value: accessibility.lineHeight,
                        min: _baseLineHeight - _lineHeightStep,
                        max: _baseLineHeight + 2 * _lineHeightStep,
                        divisions: 3,
                        onChanged: accessibility.setLineHeight,
                      );
                    },
                  ),
                  Icon(Icons.add),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildFontSelectionSection(),
          const SizedBox(height: 20),
          _buildDemoSection(),
        ],
      ),
    );
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

  //TODO: Malo uredi.
  Widget _buildDemoSection() {
    return Consumer<AccessibilityProvider>(
      builder: (context, accessibility, _) {
        return Text(
          "Gospodine, Ti si pastir moj, \nni u čem ja ne oskudijevam.",
          style: TextStyle(
            fontFamily: accessibility.readingFont.label,
            fontSize: (_baseTextSize * accessibility.readingTextScale),
            height: accessibility.lineHeight,
          ),
        );
      },
    );
  }

  Widget _buildFontSelectionSection() {
    return Consumer<AccessibilityProvider>(
      builder: (context, accessibility, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ReadingFont.values.map((font) {
            return FontTile(
              font: font,
              selected: accessibility.readingFont == font,
              onTap: () => accessibility.setReadingFont(font),
            );
          }).toList(),
        );
      },
    );
  }
}
