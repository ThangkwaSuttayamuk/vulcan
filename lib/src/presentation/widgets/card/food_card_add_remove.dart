import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FoodCardAddRemove extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.read(cartProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Theme.of(context).cardTheme.shadowColor!,
            spreadRadius: -6,
            blurRadius: 7,
            offset: const Offset(0, 10),
          )
        ]),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.secondary,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => FoodDetail(
                            id: foodId,
                          )));
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
                              image: AssetImage('assets/images/$image'))),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                name.toString(),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\$$price'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {
                                      cartState.removeToCart(foodId);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: Border.all(
                                              color: Colors.grey.shade800)),
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
                                      quantity.toString(),
                                      textAlign: TextAlign.center,
                                    )),
                                Material(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {
                                      cartState.addToCart(foodId, 1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: Border.all(
                                              color: Colors.grey.shade800)),
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
    );
  }
}
