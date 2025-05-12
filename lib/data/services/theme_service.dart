import 'package:expense_tracker/data/keys/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class ThemeService {
  Future<bool> setTheme({required bool isDark}) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      return await sharedPreferences.setBool(
        SharedPreferencesKeys.theme,
        isDark,
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> isDark() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final isDark = sharedPreferences.getBool(SharedPreferencesKeys.theme);
      if (isDark == null) {
        await setTheme(isDark: false);
        return false;
      }
      return isDark;
    } catch (e) {
      return false;
    }
  }
}
