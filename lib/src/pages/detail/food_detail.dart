import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FoodDetail extends StatefulWidget {
  const FoodDetail({super.key});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Items',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.grey.shade800),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/fried_chicken.jpg'))),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: FloatingActionButton.small(
                            backgroundColor: Colors.white,
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Pepperoni Pizza',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Pepperoni Pizza detaildlkpaokdpaokpsoarjioepisiefpsfoekpoekfpsoekp',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade800),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Ingredients:',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 90),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: List.generate(
                            19,
                            (index) => Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text('dhdmalwdaijpo'),
                                )),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ),

          Container(
            alignment: Alignment.topCenter,
            height: 100,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border:
                                    Border.all(color: Colors.grey.shade800)),
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
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border:
                                    Border.all(color: Colors.grey.shade800)),
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
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade700,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Text(
                          'Add to Cart - \$7.00',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
          // favoriteButton
          // Padding(
          //   padding: const EdgeInsets.all(15),
          //   child: FloatingActionButton(
          //     backgroundColor: Colors.white,
          //     onPressed: () {},
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30)),
          //     child: Icon(
          //       Icons.favorite_border_outlined,
          //       color: Colors.pink,
          //     ),
          //   ),
          // ),

          // footer------------------
          // Container(
          //   height: 80,
          //   decoration: BoxDecoration(color: Colors.white),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 30),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Material(
          //           borderRadius: BorderRadius.circular(40),
          //           color: Colors.white,
          //           child: InkWell(
          //             onTap: () {},
          //             borderRadius: BorderRadius.circular(40),
          //             child: SizedBox(
          //                 width: 56,
          //                 height: 56,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Icon(
          //                       Icons.home,
          //                       color: Colors.black,
          //                     ),
          //                     Text("home")
          //                   ],
          //                 )),
          //           ),
          //         ),
          //         Material(
          //           borderRadius: BorderRadius.circular(40),
          //           color: Colors.white,
          //           child: InkWell(
          //             onTap: () {

          //             },
          //             borderRadius: BorderRadius.circular(40),
          //             child: SizedBox(
          //                 width: 56,
          //                 height: 56,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Icon(
          //                       Icons.home,
          //                       color: Colors.black,
          //                     ),
          //                     Text("home")
          //                   ],
          //                 )),
          //           ),
          //         ),
          //         Material(
          //           borderRadius: BorderRadius.circular(40),
          //           color: Colors.white,
          //           child: InkWell(
          //             onTap: () {},
          //             borderRadius: BorderRadius.circular(40),
          //             child: SizedBox(
          //                 width: 56,
          //                 height: 56,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Icon(
          //                       Icons.home,
          //                       color: Colors.black,
          //                     ),
          //                     Text("home")
          //                   ],
          //                 )),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
