import 'package:flutter_application_1/src/presentation/controller/theme/theme_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(ThemeState());

  void setTheme(bool theme) {
    state = state.copyWith(theme: theme);
  }
}
