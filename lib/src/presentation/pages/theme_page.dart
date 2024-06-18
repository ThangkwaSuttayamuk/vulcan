import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemePage extends ConsumerStatefulWidget {
  const ThemePage({super.key});

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends ConsumerState<ThemePage> {
  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final themeSetState = ref.read(themeProvider.notifier);

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).cardTheme.color!,
                      spreadRadius: 6,
                      blurRadius: 7,
                      offset: Offset(0, -4),
                    )
                  ]),
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
                      ],
                    ),
                    Text(
                      'Choose Theme',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Dark Theme"),
              trailing: Switch(
                activeColor: Colors.amber,
                inactiveThumbColor: Colors.grey.shade700,
                value: themeState.theme,
                onChanged: (value) {
                  themeSetState.setTheme(value);
                },
              ),
            )
          ],
        ));
  }
}
