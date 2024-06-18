import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/core/theme/dark_theme.dart';
import 'package:flutter_application_1/src/core/theme/light_theme.dart';

import 'package:flutter_application_1/src/presentation/controller/language/language_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/theme/theme_provider.dart';
import 'package:flutter_application_1/src/presentation/pages/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodApp extends ConsumerWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider).saveLanguage;
    final theme = ref.watch(themeProvider).theme;
    return MaterialApp(
        title: "FoodApp",
        themeMode: theme ? ThemeMode.dark : ThemeMode.light,
        theme: lightTheme,
        darkTheme: darkTheme,
        locale: Locale(language ?? 'en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LoginPage());
  }
}
