import 'package:flutter/material.dart';

import '../../pages/cart.dart';
import '../../pages/home_page.dart';
import '../../pages/setting_page.dart';

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
