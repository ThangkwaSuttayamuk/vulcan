import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/pages/cart_page.dart';
import 'package:flutter_application_1/src/presentation/pages/favorite_page.dart';
import 'package:flutter_application_1/src/presentation/pages/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegularIconButton extends ConsumerStatefulWidget {
  final String name;

  const RegularIconButton({super.key, required this.name});

  @override
  _RegularIconButtonState createState() => _RegularIconButtonState();
}

class _RegularIconButtonState extends ConsumerState<RegularIconButton> {
  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> iconMap = {
      'favorite': Icons.favorite,
      'cart': Icons.shopping_cart_outlined,
    };

    final String name = widget.name;
    final IconData? selectedIcon = iconMap[name];

    return Material(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          Navigator.pushNamed(context, '/$name');
        },
        child: Icon(
          selectedIcon ?? Icons.error,
          color: Theme.of(context).textTheme.titleLarge?.color,
        ),
      ),
    );
  }

  getPageByname(String name) {
    return name == 'cart'
        ? const CartPage()
        : name == 'favorite'
            ? const FavoritePage()
            : const HomePage();
  }
}
