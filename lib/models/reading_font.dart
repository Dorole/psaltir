enum ReadingFont {
  literata(label: "Literata", fontFamily: "Literata"),
  inter(label: "Inter", fontFamily: "Inter"),
  atkinson(label: "Atkinson", fontFamily: "Atkinson"),
  openDyslexic(label: "OpenDyslexic", fontFamily: "OpenDyslexic");

  const ReadingFont({required this.label, required this.fontFamily});

  final String label;
  final String fontFamily;
}
