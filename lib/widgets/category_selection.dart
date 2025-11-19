import 'package:flutter/material.dart';
import 'package:psaltir/models/reading_models.dart';

class CategorySelection extends StatelessWidget {
  final Category selectedCategory;
  final bool categoryInOrder;
  final ValueChanged<Category?> onCategorySelected;
  final ValueChanged<bool> onOrderChanged;
  final TextEditingController categoryController;

  const CategorySelection({
    required this.selectedCategory,
    required this.categoryInOrder,
    required this.onCategorySelected,
    required this.onOrderChanged,
    required this.categoryController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          children: [
            DropdownMenu<Category>(
              controller: categoryController,
              helperText: "Odaberi kategoriju",
              initialSelection: Category.praise,
              onSelected: onCategorySelected,
              dropdownMenuEntries: Category.entries,
              requestFocusOnTap: false,
              menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                elevation: WidgetStatePropertyAll<double>(15),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: categoryInOrder,
                onChanged: onOrderChanged,
                padding: EdgeInsets.symmetric(vertical: 3),
                inactiveTrackColor: colorScheme.tertiary,
                activeTrackColor: colorScheme.tertiaryContainer,
                thumbColor: WidgetStatePropertyAll<Color>(
                  colorScheme.onTertiaryContainer,
                ),
                trackOutlineColor: WidgetStatePropertyAll<Color>(
                  colorScheme.onTertiaryContainer,
                ),
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
                color: colorScheme.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
