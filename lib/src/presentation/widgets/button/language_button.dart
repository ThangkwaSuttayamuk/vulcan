import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_application_1/src/presentation/controller/language/language_provider.dart';


class LanguageButton extends ConsumerWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final language =
    ref.watch(languageProvider.select((value) => value.language));

    return  Material(
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        onTap: () {
          ref
              .read(languageProvider.notifier)
              .saveLanguage(language);
          Navigator.pushNamed(context, '/home');
        },
        child: Text(
          AppLocalizations.of(context)?.language_save ??
              'Done',
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
