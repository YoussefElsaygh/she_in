import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  Map<String, String> _localizedStrings;
  static Map<String, String> _staticlocalizedStrings;

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  static Future<Map<String, dynamic>> loadAll(Locale locale) async {
    languageCode = locale.languageCode;
    if (_staticlocalizedStrings == null) {
      String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _staticlocalizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
    }
    return _staticlocalizedStrings;
  }

  static translateStatic(String key) {
    if (_staticlocalizedStrings[key] != null)
      return _staticlocalizedStrings[key];
    else
      return key;
  }

  static String languageCode;

  String translate(String key) {
    if (_localizedStrings[key] != null)
      return _localizedStrings[key];
    else
      return key;
  }

  String translateWithArrayInput(String key,List trans) {
    if (_localizedStrings[key] != null) {
      String local = _localizedStrings[key];
      for (int i=0;i<trans.length;i++){
        local = local.replaceAll('var'+(i+1).toString(), trans[i]);
      }
      return local;
    }
    else{
      return key;
    }

  }

  static Future<Map<String, String>> loadValues(Locale locale) async {
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
