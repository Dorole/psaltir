import 'dart:collection';

import 'package:flutter/material.dart';

/// Describes how the reading mode is chosen
enum ReadingChoice { category, number, random }

typedef CategoryEntry = DropdownMenuEntry<Category>;

/// Psalm categories
enum Category {
  praise("Slavljenički"),
  repent("Pokajnički"),
  lament("Tužbalice");

  const Category(this.label);
  final String label;
  // potencijalno dodaj ikonu

  // Used by DropdownMenu in HomePage
  static final List<CategoryEntry> entries =
      UnmodifiableListView<CategoryEntry>(
        values.map<CategoryEntry>(
          (Category category) =>
              CategoryEntry(value: category, label: category.label),
        ),
      );
}
