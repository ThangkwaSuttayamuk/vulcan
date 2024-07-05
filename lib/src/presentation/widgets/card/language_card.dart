import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/language/language_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageCard extends ConsumerStatefulWidget {
  final String title;
  const LanguageCard({super.key, required this.title});

  @override
  _LanguageCardState createState() => _LanguageCardState();
}

class _LanguageCardState extends ConsumerState<LanguageCard> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(languageProvider.notifier).initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider);

    return Material(
        color: Theme.of(context).colorScheme.secondary,
        child: InkWell(
          onTap: () {
            ref.read(languageProvider.notifier).setLanguage(widget.title);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title == 'en'
                        ? 'English'
                        : widget.title == 'th'
                            ? 'ไทย'
                            : ''),
                    language.language == widget.title
                        ? Icon(
                            Icons.check,
                            color:
                                Theme.of(context).textTheme.titleLarge?.color,
                            size: 15,
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
