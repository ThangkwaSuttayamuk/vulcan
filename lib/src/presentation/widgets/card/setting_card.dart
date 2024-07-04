import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';
import 'package:flutter_application_1/src/presentation/pages/language_page.dart';
import 'package:flutter_application_1/src/presentation/pages/theme_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingCard extends StatelessWidget {
  final String name;
  final bool checkIndex;
  const SettingCard({super.key, required this.name, required this.checkIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Material(
            color: Theme.of(context).colorScheme.secondary,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/loading');
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name == 'language'
                            ? AppLocalizations.of(context)?.setting_language ??
                                'Language'
                            : name == 'theme'
                                ? AppLocalizations.of(context)?.setting_theme ??
                                    'Theme'
                                : name == 'credit card'
                                    ? 'Credit Card'
                                    : ''),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        checkIndex
            ? const Divider(
                color: Colors.grey,
                indent: 20,
                endIndent: 20,
                height: 0,
              )
            : const SizedBox()
      ],
    );
  }

  getPageByname(String name) {
    return name == 'language'
        ? LanguagePage()
        : name == 'theme'
            ? ThemePage()
            : HomePage();
  }
}
