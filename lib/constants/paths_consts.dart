import 'dart:core';

class PathsConsts {
  static const String metadataPath = "assets/psalms_data.json";
  static const String psalmDir = "assets/psalms/";
  static const String detailsDir = "assets/details/";

  static String psalmPath(String file) => "assets/psalms/$file";
  static String detailsPath(String file) => "assets/details/$file";
}
