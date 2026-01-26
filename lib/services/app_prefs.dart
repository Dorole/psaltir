import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  AppPrefs(this.prefs);
  final SharedPreferences prefs;

  String? getString(String s) => prefs.getString(s);
  double? getDouble(String s) => prefs.getDouble(s);
  List<String>? getStringList(String s) => prefs.getStringList(s);

  Future<bool> setString(String k, String v) => prefs.setString(k, v);
  Future<bool> setDouble(String k, double v) => prefs.setDouble(k, v);
  Future<bool> setStringList(String k, List<String> v) =>
      prefs.setStringList(k, v);
  Future<bool> remove(String s) => prefs.remove(s);
}
