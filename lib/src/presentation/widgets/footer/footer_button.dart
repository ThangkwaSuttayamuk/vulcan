import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';
import 'package:flutter_application_1/src/presentation/pages/order_page.dart';
import 'package:flutter_application_1/src/presentation/pages/setting_page.dart';

class FooterButton extends StatefulWidget {
  final String name;
  final String title;
  const FooterButton({super.key, required this.name, required this.title});

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
      'message': Icons.message
    };

    final String name = widget.name;
    final IconData? selectedIcon = iconMap[name];

    return Material(
      borderRadius: BorderRadius.circular(40),
      color: Theme.of(context).colorScheme.secondary,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/$name');
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
                Text(widget.title, style: TextStyle(fontSize: 12))
              ],
            )),
      ),
    );
  }
}
