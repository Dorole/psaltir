import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/navigation_provider.dart';
import 'package:psaltir/widgets/category_selection.dart';
import '../providers/reading_provider.dart';
import '../models/reading_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _categoryInOrder = false;
  ReadingChoice? _readingChoice;
  Category? _selectedCategory;
  final Category _defaultCategory = Category.praise;
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();

  bool get _chooseByCategory => _readingChoice == ReadingChoice.category;
  bool get _chooseByNumber => _readingChoice == ReadingChoice.number;

  @override
  void dispose() {
    _categoryController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _onSubmitPressed() {
    final readingProvider = context.read<ReadingProvider>();
    final navProvider = context.read<NavigationProvider>();
    bool navigate = false;

    if (_readingChoice == null) {
      _handleRandom(readingProvider);
      navigate = true;
    } else if (_chooseByCategory) {
      _handleCategory(readingProvider);
      navigate = true;
    } else {
      navigate = _handleNumber(readingProvider);
    }

    if (navigate) {
      navProvider.openReadingPage();
    }
  }

  void _handleRandom(ReadingProvider readingProvider) {
    readingProvider.setReadingOptions(readingChoice: ReadingChoice.random);
    _showMessage("[Otvaram nasumični psalam.]");
  }

  void _handleCategory(ReadingProvider readingProvider) {
    final message = _categoryInOrder
        ? "Kategorija redom"
        : "Kategorija nasumično";
    _showMessage("$message: ${_selectedCategory?.label}");
    readingProvider.setReadingOptions(
      readingChoice: _readingChoice,
      selectedCategory: _selectedCategory ?? _defaultCategory,
      categoryInOrder: _categoryInOrder,
    );
  }

  bool _handleNumber(ReadingProvider readingProvider) {
    final text = _inputController.text.trim();
    if (text.isEmpty) {
      _showMessage("Upišite broj psalma (1 - 150)");
      return false;
    } else {
      final psalmNumber = int.tryParse(text);
      if (psalmNumber == null || psalmNumber < 1 || psalmNumber > 150) {
        _showMessage("Broj psalma mora biti između 1 i 150.");
        return false;
      } else {
        readingProvider.setReadingOptions(
          readingChoice: _readingChoice,
          psalmNumber: psalmNumber,
        );
        _showMessage("[OTVARAM PSALAM $psalmNumber]");
        return true;
      }
    }
  }

  //TODO: convert to tooltip above submit button
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  void _onRadioTap(ReadingChoice? choice) {
    setState(() {
      _readingChoice = choice;
    });
  }

  void _onCategorySelected(Category? category) {
    setState(() {
      _selectedCategory = category;
      print('Selected: $category');
    });
  }

  void _onSwitchToggle(bool value) {
    setState(() {
      _categoryInOrder = value;
      print("In Order: $_categoryInOrder");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RadioGroup<ReadingChoice>(
        groupValue: _readingChoice,
        onChanged: (ReadingChoice? value) => _onRadioTap(value),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _buildTitle(),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategorySection(),
                    const SizedBox(height: 10),
                    _buildNumberSection(),
                  ],
                ),
              ],
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  // ******************

  Widget _buildTitle() {
    var colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Text(
          "PSALTIR",
          style: TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimaryContainer,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<ReadingChoice>(
              value: ReadingChoice.category,
              toggleable: true,
            ),
            Text("Psalmi po kategoriji"),
          ],
        ),

        if (_chooseByCategory)
          CategorySelection(
            selectedCategory: _selectedCategory ?? _defaultCategory,
            categoryInOrder: _categoryInOrder,
            onCategorySelected: _onCategorySelected,
            onOrderChanged: _onSwitchToggle,
            categoryController: _categoryController,
          ),
      ],
    );
  }

  Widget _buildNumberSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio<ReadingChoice>(value: ReadingChoice.number, toggleable: true),
        Text("Broj psalma"),
        SizedBox(width: 8),

        if (_chooseByNumber)
          SizedBox(
            width: 100,
            height: 50,
            //https://api.flutter.dev/flutter/material/TextField-class.html
            child: TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "1 - 150",
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Column(
        children: [
          _buildInfoIcon(),
          const SizedBox(height: 15),
          _buildStartButton(),
        ],
      ),
    );
  }

  Widget _buildInfoIcon() {
    var colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tooltip(
          message:
              "Ako nije odabrana nijedna opcija, \npsalmi će se prikazivati nasumično.",
          triggerMode: TooltipTriggerMode.tap,
          showDuration: const Duration(seconds: 4),
          preferBelow: false,
          child: Icon(
            Icons.info_outline_rounded,
            size: 40,
            color: colorScheme.secondary,
          ),
        ), //add tooltip
      ],
    );
  }

  Widget _buildStartButton() {
    var colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _onSubmitPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: colorScheme.primary, width: 2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              "ČITAJ",
              style: TextStyle(fontSize: 40, color: colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }
}
