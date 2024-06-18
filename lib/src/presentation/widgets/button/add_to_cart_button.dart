import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/quantity/quantity_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToCartButton extends ConsumerWidget {
  final int id;
  final double price;
  const AddToCartButton({super.key, required this.id, required this.price});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(cartProvider.notifier);
    final cartlistStateRead = ref.read(cartProvider.notifier);

    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue.shade800,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          cartlistStateRead.addToCart(id, ref.watch(quantityProvider).quantity);
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            'Add to Cart - \$$price',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
