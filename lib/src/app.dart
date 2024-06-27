import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/core/theme/dark_theme.dart';
import 'package:flutter_application_1/src/core/theme/light_theme.dart';

import 'package:flutter_application_1/src/presentation/controller/language/language_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/theme/theme_provider.dart';
import 'package:flutter_application_1/src/presentation/pages/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/src/config/router/go_router.dart';

class FoodApp extends ConsumerWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider).saveLanguage;
    final theme = ref.watch(themeProvider).theme;
    return ScreenUtilInit(
        designSize: const Size(390, 850),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            home:const  LoginPage(),
            title: "FoodApp",
            themeMode: theme ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            locale: Locale(language ?? 'en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        });
  }
}
