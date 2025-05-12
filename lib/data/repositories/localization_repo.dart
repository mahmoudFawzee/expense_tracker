import 'package:expense_tracker/data/keys/shared_preferences_keys.dart';
import 'package:expense_tracker/data/services/localization_service.dart';

final class LocalizationRepo {
  final _localizationService = LocalizationService();
  Future<bool> setLang(String langCode) async =>
      await _localizationService.setLang(langCode);

  Future<bool> setEnLang() async =>
      await _localizationService.setLang(SharedPreferencesKeys.englishCode);

  Future<bool> setArLang() async =>
      await _localizationService.setLang(SharedPreferencesKeys.arabicCode);

  Future<bool> setFrLang() async =>
      await _localizationService.setLang(SharedPreferencesKeys.frenchCode);

  Future<String> getLang() async => await _localizationService.getLang();
}
