import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _singleton = LocalStorage._internal();

  SharedPreferences? _prefs;

  factory LocalStorage() {
    return _singleton;
  }

  LocalStorage._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String getString(String key, {String defaultValue = ''}) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  Future<bool> setString(String key, String value) {
    return _prefs?.setString(key, value) ?? Future.value(false);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  Future<bool> setInt(String key, int value) {
    return _prefs?.setInt(key, value) ?? Future.value(false);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  Future<bool> setBool(String key, bool value) {
    return _prefs?.setBool(key, value) ?? Future.value(false);
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs?.getDouble(key) ?? defaultValue;
  }

  Future<bool> setDouble(String key, double value) {
    return _prefs?.setDouble(key, value) ?? Future.value(false);
  }

  List<String> getStringList(String key,
      {List<String> defaultValue = const []}) {
    return _prefs?.getStringList(key) ?? defaultValue;
  }

  Future<bool> setStringList(String key, List<String> value) {
    return _prefs?.setStringList(key, value) ?? Future.value(false);
  }

  Future<bool> remove(String key) {
    return _prefs?.remove(key) ?? Future.value(false);
  }

  Future<bool?> clear() async {
    return await _prefs?.clear();
  }



}

