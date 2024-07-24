import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodCardAddRemove extends ConsumerStatefulWidget {
  final int foodId;
  final String name;
  final String description;
  final double price;
  final String image;
  final int quantity;
  const FoodCardAddRemove({
    super.key,
    required this.foodId,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.quantity,
  });

  @override
  _FoodCardAddRemoveState createState() => _FoodCardAddRemoveState();
}

class _FoodCardAddRemoveState extends ConsumerState<FoodCardAddRemove> {
  double offset = 0.0;
  final double threshold = 10.w;
  bool isSwipingLeft = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 15.h),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      offset = 0;
                    });

                    ref
                        .read(cartProvider.notifier)
                        .deleteFormCart(widget.foodId);
                  },
                  child: Stack(alignment: Alignment.center, children: [
                    SizedBox(
                      height: 120.h,
                      width: 85.w,
                    ),
                    Icon(Icons.delete_rounded, color: Colors.white),
                  ]),
                ),
              ),
            ],
          ),
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                offset += details.delta.dx;
                if (offset < -100) {
                  offset = -100;
                } else if (offset >= 0) {
                  offset = 0;
                }
                if (offset < 0) {
                  isSwipingLeft = true;
                } else {
                  isSwipingLeft = false;
                }
              });
            },
            onHorizontalDragEnd: (details) {
              if (offset.abs() > threshold) {
                setState(() {
                  if (isSwipingLeft) {
                    offset = -100.0;
                  } else {
                    offset = 0.0;
                  }
                });
              } else {
                setState(() {
                  offset = 0.0;
                });
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.translationValues(offset, 0, 0),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.secondary,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail', arguments: {
                      "id": widget.foodId,
                      "formPage": 'cart',
                      "quantity": widget.quantity
                    });
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            height: 80.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/${widget.image}'))),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.name.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('\$${widget.price}'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Material(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        borderRadius: BorderRadius.circular(30),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          onTap: () {
                                            setState(() {
                                              offset = 0;
                                            });
                                            ref
                                                .read(cartProvider.notifier)
                                                .removeToCart(widget.foodId);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade800)),
                                            child: const Icon(
                                              Icons.remove,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 50.w,
                                          child: Text(
                                            widget.quantity.toString(),
                                            textAlign: TextAlign.center,
                                          )),
                                      Material(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        borderRadius: BorderRadius.circular(30),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          onTap: () {
                                            ref
                                                .read(cartProvider.notifier)
                                                .addToCart(widget.foodId, 1);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade800)),
                                            child: const Icon(
                                              Icons.add,
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
            ),
          ),
        ],
      ),
    );
  }
}
