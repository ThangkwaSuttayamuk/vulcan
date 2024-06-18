
import 'package:flutter_application_1/src/presentation/controller/theme/theme_controller.dart';
import 'package:flutter_application_1/src/presentation/controller/theme/theme_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});
