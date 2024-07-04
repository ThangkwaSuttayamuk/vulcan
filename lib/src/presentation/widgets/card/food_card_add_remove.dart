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
    final cartState = ref.read(cartProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: Stack(
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
                    cartState.deleteFormCart(widget.foodId);
                  },
                  child: const Stack(alignment: Alignment.center, children: [
                    SizedBox(
                      height: 120,
                      width: 90,
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
                    Navigator.pushNamed(context, '/detail',
                        arguments: widget.foodId);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
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
                              const SizedBox(
                                height: 40,
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
                                            cartState
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
                                          width: 50,
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
                                            cartState.addToCart(
                                                widget.foodId, 1);
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
