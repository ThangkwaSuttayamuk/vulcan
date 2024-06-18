import 'package:flutter_application_1/src/presentation/controller/language/language_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageNotifier extends StateNotifier<LanguageState> {
  LanguageNotifier() : super(LanguageState());

  void initData() {
    state = state.copyWith(language: state.saveLanguage);
  }

  void setLanguage(String lang) {
    state = state.copyWith(language: lang);
  }

  void saveLanguage(String lang) {
    state = state.copyWith(saveLanguage: lang);
  }
}
