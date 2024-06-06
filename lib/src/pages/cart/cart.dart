import 'package:flutter/material.dart';

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
                return Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        //
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/fried_chicken.jpg'))),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "dksjcjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjld",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('\$3.99'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              onTap: () {},
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade800)),
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.grey.shade800,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: 50,
                                              child: Text(
                                                '1',
                                                textAlign: TextAlign.center,
                                              )),
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              onTap: () {},
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade800)),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.grey.shade800,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
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
