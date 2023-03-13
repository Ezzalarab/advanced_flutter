// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advanced_flutter/presentation/languages/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsLangKey = "prefs_lang_key";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(
    this._sharedPreferences,
  );

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsLangKey);
    if (language != null && language.isNotEmpty && language != '') {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }
}
