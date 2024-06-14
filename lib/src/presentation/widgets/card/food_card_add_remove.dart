import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/domain/entities/cart_entity.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodCardAddRemove extends ConsumerWidget {
  final CartEntity food;

  const FoodCardAddRemove({super.key, required this.food});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.read(cartProvider.notifier);
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: -6,
            blurRadius: 7,
            offset: Offset(0, 10),
          )
        ]),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          child: InkWell(
            onTap: () {
              print(food.foodId);
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => FoodDetail(
                            id: food.foodId,
                            name: food.name,
                            description: food.description,
                            price: food.price,
                            image: food.image,
                          )));
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
                              image:
                                  AssetImage('assets/images/${food.image}'))),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                food.name.toString(),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\$${food.price}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {
                                      // print(food.foodId);
                                      cartState.removeToCart(food.foodId);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: Border.all(
                                              color: Colors.grey.shade800)),
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
                                      food.quantity.toString(),
                                      textAlign: TextAlign.center,
                                    )),
                                Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () {
                                      cartState.addToCart(food.foodId, 1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: Border.all(
                                              color: Colors.grey.shade800)),
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
      ),
    );
  }
}
