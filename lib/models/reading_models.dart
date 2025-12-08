import 'dart:collection';
import 'package:flutter/material.dart';

enum ReadingChoice { category, number, random }

typedef CategoryEntry = DropdownMenuEntry<Category>;

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

  // string --> enum conversion
  // static Category? fromString (String s) {
  //   try {
  //     return Category.values.firstWhere((categoryEnum) => categoryEnum.name == s);
  //   } catch (_) {
  //     throw FormatException("Unknown category: $s");
  //   }
  // }
}
