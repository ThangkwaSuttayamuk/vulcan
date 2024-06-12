import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/pages/cart_page.dart';
import 'package:flutter_application_1/src/presentation/pages/favorite_page.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';

class RegularIconButton extends StatefulWidget {
  final String name;

  const RegularIconButton({super.key, required this.name});

  @override
  State<RegularIconButton> createState() => _RegularIconButtonState();
}

class _RegularIconButtonState extends State<RegularIconButton> {
  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> iconMap = {
      'favorite': Icons.favorite,
      'cart': Icons.shopping_bag_outlined,
    };

    final String name = widget.name;
    final IconData? selectedIcon = iconMap[name];

    return Material(
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      getPageByname(widget.name)));
        },
        child: Icon(
          selectedIcon ?? Icons.error, // default icon if not found
          color: Color.fromARGB(190, 13, 72, 161),
        ),
      ),
    );
  }

  getPageByname(String name) {
    return name == 'cart'
        ? CartPage()
        : name == 'favorite'
            ? FavoritePage()
            : HomePage();
  }
}
