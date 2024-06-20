import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_state.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_state.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_provider.dart';
import 'package:flutter_application_1/src/presentation/pages/order_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card_add_remove.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final cartstate = ref.read(cartProvider.notifier);
    final order = ref.watch(orderProvider);
    // final orderState = ref.read(orderProvider.notifier);

    if (cartlistState.status != CartStatus.success &&
        cartlistState.status != CartStatus.empty) {
      return const Scaffold(
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
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
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
                                  cartstate.initData();
                                  showModalBottomSheet<void>(
                                      context: context,
                                      isScrollControlled: true,
                                      showDragHandle: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0),
                                        ),
                                      ),
                                      builder: (context) {
                                        return Wrap(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons
                                                            .location_on_outlined),
                                                        Text(
                                                          'Delivery Address:',
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      maxLines: 3,
                                                      cursorColor: Colors.black,
                                                      onChanged: (value) {
                                                        ref
                                                            .read(cartProvider
                                                                .notifier)
                                                            .setAddress(value);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(10),
                                                        hintText:
                                                            'Example:\n1234 Main Street, Lincoln, NE 68509',
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey.shade500,
                                                            fontSize: 14),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.phone),
                                                        Text(
                                                          'Phone Number:',
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      maxLines: 1,
                                                      cursorColor: Colors.black,
                                                      onChanged: (value) {
                                                        cartstate.setTel(value);
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(10),
                                                        hintText: '089XXXXXXX',
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey.shade500,
                                                            fontSize: 14),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons
                                                            .shopping_bag_outlined),
                                                        Text('Order Summary:')
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Column(
                                                        children: List.generate(
                                                            cartlistState
                                                                    .cartList
                                                                    ?.length ??
                                                                0, (i) {
                                                      final cartItem =
                                                          cartlistState
                                                              .cartList?[i];
                                                      return Column(
                                                        children: [
                                                          foodCard(
                                                              cartItem?.name ??
                                                                  '',
                                                              cartItem?.image ??
                                                                  '',
                                                              cartItem?.price ??
                                                                  0.0,
                                                              cartItem?.quantity ??
                                                                  0),
                                                          divider(
                                                              i,
                                                              cartlistState
                                                                      .cartList
                                                                      ?.length ??
                                                                  0)
                                                        ],
                                                      );
                                                    })),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Total',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                        Text(
                                                          '\$${ref.read(cartProvider.notifier).getTotal()}',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(children: [
                                                      Expanded(
                                                          child: MaterialButton(
                                                              enableFeedback:
                                                                  false,
                                                              child: Text(
                                                                'Order',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              height: 40,
                                                              color: Colors.blue
                                                                  .shade800,
                                                              disabledColor:
                                                                  Colors.grey
                                                                      .shade600,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              onPressed: () {
                                                                if (cartstate
                                                                        .getAddress()
                                                                        .isEmpty ||
                                                                    cartstate
                                                                        .getTel()
                                                                        .isEmpty) {
                                                                } else {
                                                                  ref
                                                                      .read(orderProvider
                                                                          .notifier)
                                                                      .addOrder(
                                                                          cartstate
                                                                              .getAddress(),
                                                                          cartstate
                                                                              .getTel());
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    PageRouteBuilder(
                                                                      pageBuilder: (context,
                                                                              animation,
                                                                              secondaryAnimation) =>
                                                                          const OrderPage(),
                                                                      transitionsBuilder: (context,
                                                                          animation,
                                                                          secondaryAnimation,
                                                                          child) {
                                                                        return child;
                                                                      },
                                                                    ),
                                                                  );
                                                                }
                                                              }))
                                                    ]),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
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

  Widget foodCard(String name, String image, double price, int quantity) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("${quantity}x"),
              SizedBox(
                width: 20,
              ),
              Text(name),
            ],
          ),
          Text("${quantity * price}")
        ],
      ),
    );
  }

  Widget divider(int index, int length) {
    return index == length - 1
        ? SizedBox()
        : Divider(
            color: Colors.grey.shade400,
            height: 0,
          );
  }
}
