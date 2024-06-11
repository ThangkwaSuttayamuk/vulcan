import 'package:flutter/material.dart';

import '../widgets/card/food_card_add_remove.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Cart (0)',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade800),
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                  children: List.generate(4, (i) {
                return FoodCardAddRemove();
              })),
            ),
          ),
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
                          '\฿135',
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
                    // Material(
                    //   borderRadius: BorderRadius.circular(10),
                    //   color: Colors.blue.shade700,
                    //   child: InkWell(
                    //     borderRadius: BorderRadius.circular(10),
                    //     onTap: () {},
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 30, vertical: 10),
                    //       child: Text(
                    //         'Order',
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // )
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
