import 'dart:convert';
import 'package:flutter/services.dart';

class AppLocalizations {
  final String locale;

  AppLocalizations(this.locale, this._localizedStrings);

  static Future<AppLocalizations> load(String locale) async {
    final String jsonString =
        await rootBundle.loadString('assets/lang/$locale.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return AppLocalizations._(locale, jsonMap.cast<String, String>());
  }

  final Map<String, String> _localizedStrings;

  AppLocalizations._(this.locale, this._localizedStrings);

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}
