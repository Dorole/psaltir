import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/pages/reading_page.dart';
import '../providers/reading_provider.dart';
import '../models/reading_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _chooseByCategory = false;
  bool _chooseByNumber = false;
  bool _categoryInOrder = false;
  ReadingChoice? _readingChoice;
  Category? _selectedCategory;
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _categoryController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _onSubmitPressed() {
    final readingProvider = context.read<ReadingProvider>();
    bool navigate = false;

    if (!_chooseByCategory && !_chooseByNumber) {
      readingProvider.setReadingOptions(readingChoice: ReadingChoice.random);
      _showMessage("[Otvaram nasumični psalam.]");
      navigate = true;
    }

    if (_chooseByCategory) {
      final message = _categoryInOrder
          ? "Kategorija redom"
          : "Kategorija nasumično";
      _showMessage("$message: ${_selectedCategory?.label}");
      readingProvider.setReadingOptions(
        readingChoice: _readingChoice,
        selectedCategory: _selectedCategory,
        categoryInOrder: _categoryInOrder,
      );
      navigate = true;
    }

    if (_chooseByNumber) {
      final text = _inputController.text.trim();
      if (text.isEmpty) {
        _showMessage("Upišite broj psalma (1 - 150)");
        return;
      } else {
        final psalmNumber = int.tryParse(text);
        if (psalmNumber == null || psalmNumber < 1 || psalmNumber > 150) {
          _showMessage("Broj psalma mora biti između 1 i 150.");
          return;
        } else {
          readingProvider.setReadingOptions(
            readingChoice: _readingChoice,
            psalmNumber: psalmNumber,
          );
          _showMessage("[OTVARAM PSALAM $psalmNumber]");
          navigate = true;
        }
      }
    }

    if (navigate) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ReadingPage()),
      );
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
      _chooseByCategory = choice == ReadingChoice.category;
      _chooseByNumber = choice == ReadingChoice.number;
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
          children: [
            _buildTitle(),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ***** PSALAM IZ KATEGORIJE *****
                Column(
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
                  ],
                ),

                if (_chooseByCategory)
                  // TREBALO BI U ZASEBAN CLASS?
                  // WRAP IN ROW? ILI COLUMN S DVA ROWA, ili ukljuci i radio kao 3.row
                  DropdownMenu<Category>(
                    controller: _categoryController,
                    helperText: "Odaberi kategoriju",
                    initialSelection: Category.praise,
                    onSelected: _onCategorySelected,
                    dropdownMenuEntries: Category.entries,
                    requestFocusOnTap: false,
                    menuStyle: MenuStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Colors.white,
                      ),
                      elevation: WidgetStatePropertyAll<double>(15),
                    ),
                  ),

                if (_chooseByCategory)
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: _categoryInOrder,
                          onChanged: (bool value) => _onSwitchToggle(value),
                          padding: EdgeInsets.symmetric(vertical: 3),
                          //boja
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text("Redom"),
                      ),
                      Tooltip(
                        message:
                            "Ostavite isključeno ako želite nasumičan \nprikaz psalama unutar kategorije.",
                        triggerMode: TooltipTriggerMode.tap,
                        showDuration: const Duration(seconds: 4),
                        preferBelow: true,
                        child: Icon(
                          Icons.info_outline_rounded,
                          color: Colors.brown[400],
                        ),
                      ), //add tooltip
                    ],
                  ),

                SizedBox(height: 30),

                // ***** BROJ PSALMA *****
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<ReadingChoice>(
                      value: ReadingChoice.number,
                      toggleable: true,
                    ),
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
                ),

                SizedBox(height: 50),

                // ***** INFO ICON *****
                Row(
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
                        color: Colors.brown[400],
                      ),
                    ), //add tooltip
                  ],
                ),

                SizedBox(height: 15),

                // ***** BUTTON *****
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _onSubmitPressed,
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          side: BorderSide(color: Colors.brown, width: 2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          "ČITAJ",
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ******************

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: const Text(
          "PSALTIR",
          style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
