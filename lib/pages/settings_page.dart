import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/models/navigation_models.dart';
import 'package:psaltir/models/reading_font.dart';
import 'package:psaltir/providers/accessibility_provider.dart';
import 'package:psaltir/providers/theme_provider.dart';
import 'package:psaltir/widgets/font_tile.dart';
import 'package:psaltir/widgets/top_bar_back_reading.dart';

// podijeli u sekcije: Accessibility section, Theme section, Import/Export (service), About section

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  final double _lineHeightStep = 0.2;

  @override
  Widget build(BuildContext context) {
    var children = [
      _buildHeader(context),
      const SizedBox(height: 20),
      _buildTextSizeSlider(),
      const SizedBox(height: 20),
      _buildLineHeightSlider(),
      const SizedBox(height: 20),
      _buildFontSelectionSection(),
      const SizedBox(height: 20),
      _buildDemoSection(),
      const SizedBox(height: 20),
      _buildThemeSelectionSection(),
    ];
    return Scaffold(body: Column(children: children));
  }

  Widget _buildHeader(BuildContext context) {
    return TopBarBackReading(title: AppPage.settings.label.toUpperCase());
  }

  Widget _buildTextSizeSlider() {
    return Semantics(
      label: "Veličina teksta psalma",
      hint: "Podesite veličinu teksta pomicanjem klizača",

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Veličina teksta",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Consumer<TextSettingsProvider>(
            builder: (_, settings, _) {
              return Row(
                children: [
                  ExcludeSemantics(
                    child: Text(
                      "A",
                      style: TextStyle(
                        fontSize: settings.baseTextSize * settings.minTextScale,
                      ),
                    ),
                  ),
                  Consumer<TextSettingsProvider>(
                    builder: (_, settings, _) {
                      return Slider(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        value: settings.readingTextScale,
                        min: settings.minTextScale,
                        max: settings.maxTextScale,
                        divisions: 8,
                        onChanged: settings.setReadingTextScale,
                      );
                    },
                  ),
                  ExcludeSemantics(
                    child: Text(
                      "A",
                      style: TextStyle(
                        fontSize: settings.baseTextSize * settings.maxTextScale,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLineHeightSlider() {
    return Semantics(
      label: "Visina proreda",
      hint: "Podesite visinu proreda pomicanjem klizača",

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Visina proreda",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ExcludeSemantics(child: Icon(Icons.remove)),
              Consumer<TextSettingsProvider>(
                builder: (_, settings, _) {
                  return Slider(
                    value: settings.lineHeight,
                    min: settings.baseLineHeight - _lineHeightStep,
                    max: settings.baseLineHeight + 2 * _lineHeightStep,
                    divisions: 3,
                    onChanged: settings.setLineHeight,
                  );
                },
              ),
              ExcludeSemantics(child: Icon(Icons.add)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDemoSection() {
    return Consumer<TextSettingsProvider>(
      builder: (context, settings, _) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiary,
              width: 4,
            ),
          ),
          child: Text(
            "Gospodine, Ti si pastir moj, \nni u čem ja ne oskudijevam.",
            style: settings.readingTextStyle,
          ),
        );
      },
    );
  }

  Widget _buildFontSelectionSection() {
    return Consumer<TextSettingsProvider>(
      builder: (context, settings, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ReadingFont.values.map((font) {
            return FontTile(
              font: font,
              selected: settings.readingFont == font,
              onTap: () => settings.setReadingFont(font),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildThemeSelectionSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Tema aplikacije",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return Row(
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: themeProvider.setLightTheme,
                      icon: Icon(Icons.sunny),
                      isSelected: themeProvider.isLight,
                      tooltip: "Dodirni dvaput za odabir svijetle teme",
                    ),
                    ExcludeSemantics(child: Text("Svijetla")),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    IconButton(
                      onPressed: themeProvider.setDarkTheme,
                      icon: Icon(Icons.nightlight_round_outlined),
                      isSelected: themeProvider.isDark,
                      tooltip: "Dodirni dvaput za odabir tamne teme",
                    ),
                    ExcludeSemantics(child: Text("Tamna")),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void foo() {}
}
