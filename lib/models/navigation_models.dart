enum AppPage {
  home("Psaltir"),
  accessibility("Pristupačnost"),
  settings("Postavke"),
  bookmarks("Omiljeni psalmi"),
  reading("");

  final String label;
  const AppPage(this.label);
}

enum PsalmPageSlot {
  previous(slotIndex: 0),
  current(slotIndex: 1),
  next(slotIndex: 2);

  const PsalmPageSlot({required this.slotIndex});
  final int slotIndex;
}
