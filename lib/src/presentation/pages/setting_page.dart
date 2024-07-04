import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/user/user_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/setting_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  final List<String> _setting = [
    "language",
    "theme",
  ];

  final List<String> _information = ["credit card"];

  late SharedPreferences loginData;
  late String username;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userProvider);
    final userState = ref.read(userProvider.notifier);

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)?.setting_header ?? 'Setting',
            style: const TextStyle(
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
            SettingGroup(header: 'Information', setting: _information),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  userState.logOut();
                  loginData.setBool('login', true);
                  loginData.setInt('id', 0);
                  if (loginData.getInt('id') == 0 &&
                      loginData.getBool('login') == true) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)?.log_out ?? 'Log Out',
                ),
              ),
            ),
          ]),
        ));
  }
}
