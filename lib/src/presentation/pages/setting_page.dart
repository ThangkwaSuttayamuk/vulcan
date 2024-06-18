import 'package:flutter/material.dart';

import 'package:flutter_application_1/src/presentation/widgets/card/setting_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final List<String> _setting = [
    "Language",
    "Theme",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)?.setting_header ?? 'Setting',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SettingGroup(
                header: AppLocalizations.of(context)?.setting_header_group ??
                    'Setting',
                setting: _setting),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)?.log_out ?? 'Log Out',
                ),
              ),
            ),
          ]),
        ));
  }
}
