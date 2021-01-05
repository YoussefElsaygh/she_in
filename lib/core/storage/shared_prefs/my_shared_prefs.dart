import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

class MySharedPrefs {
  static MySharedPrefs _instance = new MySharedPrefs._internal();

  MySharedPrefs._internal();

  factory MySharedPrefs() => _instance;

  static Future<String> getStringVal(String _key) async {
    if (await isAvailable(_key)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String stringValue = prefs.getString(_key);

      return stringValue;
    } else {
      return null;
    }
  }

  static Future<Map> getJsonAsMap(String _key) async {
    if (await isAvailable(_key)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map stringValue = JsonDecoder().convert(prefs.getString(_key) ?? '');
      return stringValue;
    } else
      return null;
  }

  static setMapAsJson(String _key, dynamic _val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, json.encode(_val));
  }

  static Future<int> getIntVal(String _key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.get(_key) ?? 0;

    return intValue;
  }

  static setStringVal(String _key, String _val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _val);
  }

  static setIntVal(String _key, int _val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_key, _val);
  }

  static deleteKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<bool> isAvailable(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool available = prefs.containsKey(key);

    return available;
  }

  static setBooleanVal(String _key, bool _val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, _val);
  }

  static Future<bool> getBooleanVal(String _key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool booleanValue = prefs.getBool(_key);

    return booleanValue;
  }
}
