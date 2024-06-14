import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card_add_remove.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Cart (${ref.read(cartProvider.notifier).getTotalAmount()})',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade800),
            ),
          ),
          body: SafeArea(
              child: Column(
            children: [
              Expanded(
                child: cartlistState.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : cartlistState.error != null
                        ? Center(child: Text("Error: ${cartlistState.error}"))
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Column(
                                    children: List.generate(
                                        cartlistState.cartList.length, (i) {
                                  final cartItem = cartlistState.cartList[i];
                                  return FoodCardAddRemove(
                                    food: cartItem,
                                  );
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
          color: Colors.white,
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
                        color: Colors.white,
                        child: Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.white,
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
                          child: Text(
                            "Order",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          height: 40,
                          color: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {}),
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
