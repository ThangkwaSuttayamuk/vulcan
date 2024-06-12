import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/pages/favorite_page.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/setting_group.dart';

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
        appBar: AppBar(
          title: Text(
            'Setting',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey.shade800),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SettingGroup(header: 'Setting', setting: _setting),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {

                },
                child: Text('Log Out'),
              ),
            ),
          ]),
        ));
  }

  getPageByname(String name) {
    return name == 'setting'
        ? SettingPage()
        : name == 'favorite'
            ? FavoritePage()
            : HomePage();
  }
}
