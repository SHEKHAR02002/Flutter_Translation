import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController with ChangeNotifier {
  Locale? _appLocal;
  Locale? get appLocal => _appLocal;

  Future changeLanguage(Locale type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _appLocal = type;

    if (type == const Locale("en")) {
      await sp.setString('language_code', 'en');
    } else {
      await sp.setString('language_code', 'es');
    }
    notifyListeners();
  }
}
