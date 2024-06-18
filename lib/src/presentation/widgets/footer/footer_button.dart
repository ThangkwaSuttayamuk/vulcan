import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/pages/cart_page.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';
import 'package:flutter_application_1/src/presentation/pages/order_page.dart';
import 'package:flutter_application_1/src/presentation/pages/setting_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FooterButton extends StatefulWidget {
  final String name;
  const FooterButton({super.key, required this.name});

  @override
  State<FooterButton> createState() => _FooterButtonState();
}

class _FooterButtonState extends State<FooterButton> {
  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> iconMap = {
      'order': Icons.history,
      'home': Icons.home,
      'setting': Icons.settings,
    };

    final String name = widget.name;
    final IconData? selectedIcon = iconMap[name];

    return Material(
      borderRadius: BorderRadius.circular(40),
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  getPageByname(name),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
          );
        },
        borderRadius: BorderRadius.circular(40),
        child: SizedBox(
            width: 56,
            height: 56,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  selectedIcon ?? Icons.error, // default icon if not found
                ),
                Text(widget.name)
              ],
            )),
      ),
    );
  }

  getPageByname(String name) {
    return name == 'order'
        ? const OrderPage()
        : name == 'setting'
            ? const SettingPage()
            : const HomePage();
  }
}
