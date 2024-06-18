import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/core/resources/app_result.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_state.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_state.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card_add_remove.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cartProvider.notifier).cartFoods();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartlistState = ref.watch(cartProvider);
    print(cartlistState.status);

    if (cartlistState.status != CartStatus.success &&
        cartlistState.status != CartStatus.empty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: Text(
              '${AppLocalizations.of(context)?.cart_header ?? 'Cart'} (${ref.read(cartProvider.notifier).getTotalAmount()})',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          body: SafeArea(
              child: Column(
            children: [
              Expanded(
                child: cartlistState.status == FavoriteFoodStatus.loading
                    ? Center(child: CircularProgressIndicator())
                    : cartlistState.error != null
                        ? Center(child: Text("Error: ${cartlistState.error}"))
                        : cartlistState.status == CartStatus.empty
                            ? Center(
                                child: Text(
                                AppLocalizations.of(context)?.cart_empty ??
                                    'Empty Cart',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ))
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                        children: List.generate(
                                            cartlistState.cartList?.length ?? 0,
                                            (i) {
                                      final cartItem =
                                          cartlistState.cartList?[i];
                                      return FoodCardAddRemove(
                                          foodId: cartItem?.foodId ?? 0,
                                          name: cartItem?.name ?? '',
                                          description:
                                              cartItem?.description ?? '',
                                          price: cartItem?.price ?? 0.0,
                                          image: cartItem?.image ?? '',
                                          quantity: cartItem?.quantity ?? 0);
                                    })),
                                    SizedBox(
                                      height: 100,
                                    )
                                  ],
                                ),
                              ),
              ),
            ],
          )),
        ),
        Container(
          alignment: Alignment.topCenter,
          height: 130,
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          AppLocalizations.of(context)?.cart_total ?? 'Total',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Material(
                        color: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          '\$${ref.read(cartProvider.notifier).getTotal()}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                          enableFeedback: false,
                          child: Text(
                            AppLocalizations.of(context)?.cart_order ?? 'Order',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          height: 40,
                          color: Colors.blue.shade800,
                          disabledColor: Colors.grey.shade600,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: cartlistState.status == CartStatus.empty
                              ? null
                              : () {

                                
                              }),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
