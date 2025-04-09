import 'package:expense_tracker/data/repositories/theme_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);
  final _themeRepo = ThemeRepo();
  void setDarkTheme() async {
    await _themeRepo.setDarkTheme();
    await isDarkTheme();
  }

  void setLightTheme() async {
    await _themeRepo.setLightTheme();
    await isDarkTheme();
  }

  void setTheme({required bool isDark}) async {
    await _themeRepo.setTheme(isDark: isDark);
    await isDarkTheme();
  }

  Future isDarkTheme() async {
    final isDark = await _themeRepo.isDark();
    emit(isDark);
  }
}
