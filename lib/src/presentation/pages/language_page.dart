import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/language/language_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/language_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 15, top: 60),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                            )),
                        Material(
                          color: Theme.of(context).colorScheme.secondary,
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(languageProvider.notifier)
                                  .saveLanguage(language.language);
                              Navigator.pushNamed(context, '/home');
                            },
                            child: Text(
                              AppLocalizations.of(context)?.language_save ??
                                  'Done',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      AppLocalizations.of(context)?.language_header ??
                          'Choose Language',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            divider(0),
            const LanguageCard(title: 'en'),
            divider(20),
            const LanguageCard(title: 'th'),
            divider(0)
          ],
        ));
  }

  Widget divider(double indent) {
    return Divider(
      color: Colors.grey.shade200,
      indent: indent,
      endIndent: indent,
      height: 0,
    );
  }
}
