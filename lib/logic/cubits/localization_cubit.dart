import 'package:expense_tracker/data/repositories/localization_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationCubit extends Cubit<String> {
  LocalizationCubit() : super('en');
  final _localizationRepo = LocalizationRepo();
  void setLocalization(String langCode) async {
    await _localizationRepo.setLang(langCode);
    await getLocalization();
  }
  void setEnLocalization() async {
    await _localizationRepo.setEnLang();
    await getLocalization();
  }

  void setArLocalization() async {
    await _localizationRepo.setArLang();
    await getLocalization();
  }

  void setRrLocalization() async {
    await _localizationRepo.setFrLang();
    await getLocalization();
  }

  Future getLocalization() async {
    final lang = await _localizationRepo.getLang();
    emit(lang);
  }
}
