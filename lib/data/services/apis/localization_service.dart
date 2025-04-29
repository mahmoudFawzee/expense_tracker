import 'package:expense_tracker/data/keys/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocalizationService {
  Future<bool> setLang(String langCode) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      return await preferences.setString(SharedPreferencesKeys.lang, langCode);
    } catch (e) {
      return false;
    }
  }

  Future<String> getLang() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final lang = preferences.getString(SharedPreferencesKeys.lang);
      if (lang == null) {
        await setLang(SharedPreferencesKeys.englishCode);
        return SharedPreferencesKeys.englishCode;
      }
      return lang;
    } catch (e) {
      return SharedPreferencesKeys.englishCode;
    }
  }
}
