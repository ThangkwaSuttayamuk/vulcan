import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/cart/cart.dart';
import 'package:flutter_application_1/src/pages/favorite/favorite.dart';
import 'package:flutter_application_1/src/pages/home/home_page.dart';
import 'package:flutter_application_1/src/pages/setting/setting_page.dart';

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
      'favorite': Icons.favorite,
      'home': Icons.home,
      'setting': Icons.settings,
    };

    final String name = widget.name;
    final IconData? selectedIcon = iconMap[name];

    return Material(
      borderRadius: BorderRadius.circular(40),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => getPageByname(name)));
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
                  color: Colors.black,
                ),
                Text(widget.name)
              ],
            )),
      ),
    );
  }

  getPageByname(String name) {
    return name == 'cart'
        ? CartPage()
        : name == 'setting'
            ? SettingPage()
            : HomePage();
  }
}
