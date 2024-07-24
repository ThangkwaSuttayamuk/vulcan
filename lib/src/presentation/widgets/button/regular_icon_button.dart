import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
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
    final cartList = ref.watch(cartProvider.select((value) => value.cartList));

    final Map<String, IconData> iconMap = {
      'favorite': Icons.favorite,
      'cart': Icons.shopping_cart_outlined,
    };

    final String name = widget.name;
    final IconData? selectedIcon = iconMap[name];

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5, bottom: 3),
          child: Material(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.pushNamed(context, '/$name');
              },
              child: Icon(
                size: 25,
                selectedIcon ?? Icons.error,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
          ),
        ),
        name == 'cart' && (cartList?.length ?? 0) > 0
            ? Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 8,
                  ),
                  Text(
                    '${(cartList?.length ?? 0) > 99 ? '99+' : cartList?.length}',
                    style: TextStyle(
                        fontSize: (cartList?.length ?? 0) > 99 ? 8 : 10,
                        color: Colors.white),
                  ),
                ],
              )
            : SizedBox()
      ],
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
