import 'package:expense_tracker/data/repositories/theme_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);
  final _themeRepo = ThemeRepo();
  void setDarkTheme() async {
    await _themeRepo.setTheme(isDark: true);
    emit(true);
  }

  void setLightTheme() async {
    await _themeRepo.setTheme(isDark: false);
    emit(false);
  }

  void isDark() async {
    final isDark = await _themeRepo.isDark();
    emit(isDark);
  }
}
