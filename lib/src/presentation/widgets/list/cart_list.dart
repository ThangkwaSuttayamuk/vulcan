import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card_add_remove.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartList extends ConsumerWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
    final cartList = ref.watch(cartProvider.select((value) => value.cartList));

    return Column(
        children: List.generate(cartList?.length ?? 0, (i) {
      final cartItem = cartList?[i];
      return FoodCardAddRemove(
          foodId: cartItem?.foodId ?? 0,
          name: cartItem?.name ?? '',
          description: cartItem?.description ?? '',
          price: cartItem?.price ?? 0.0,
          image: cartItem?.image ?? '',
          quantity: cartItem?.quantity ?? 0);
    }));
  }
}


