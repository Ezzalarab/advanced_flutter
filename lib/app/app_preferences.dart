import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/languages/language_manager.dart';

const String prefsKeyLang = "prefs_key_lang";
const String prefsKeyOnBoardingViewed = "prefs_key_on_bording_viewed";
const String prefsKeyIsLoggedIn = "prefs_key_is_logged_in";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(
    this._sharedPreferences,
  );

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    if (language != null && language.isNotEmpty && language != '') {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> setIsOnBoardingViewed() async {
    _sharedPreferences.setBool(prefsKeyOnBoardingViewed, true);
  }

  Future<bool> getIsOnBoardingViewed() async {
    return _sharedPreferences.getBool(prefsKeyOnBoardingViewed) ?? false;
  }

  Future<void> setIsLoggedIn() async {
    _sharedPreferences.setBool(prefsKeyIsLoggedIn, true);
  }

  Future<bool> getIsLoggedIn() async {
    return _sharedPreferences.getBool(prefsKeyIsLoggedIn) ?? false;
  }

  Future<void> setIsLogOut() async {
    _sharedPreferences.setBool(prefsKeyIsLoggedIn, false);
  }
}
