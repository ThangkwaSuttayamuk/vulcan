import 'package:flutter_application_1/src/presentation/controller/language/language_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/language/language_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider =
    StateNotifierProvider.autoDispose<LanguageNotifier, LanguageState>((ref) {
  return LanguageNotifier();
});
