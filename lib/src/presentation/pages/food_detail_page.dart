import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/quantity/quantity_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/add_to_cart_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/favorite_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodDetail extends ConsumerStatefulWidget {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;

  const FoodDetail({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends ConsumerState<FoodDetail> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(quantityProvider.notifier).initData();
      ref.read(cartProvider.notifier);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quantityState = ref.watch(quantityProvider);
    final quantityControllerState = ref.read(quantityProvider.notifier);
    // final cartlistState = ref.read(cartProvider.notifier);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
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
          body: SingleChildScrollView(
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
                                      'assets/images/${widget.image}'))),
                        ),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: FavoriteButton(foodId: widget.id)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.name,
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
                            widget.description,
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
                  // TextCard(
                  //   listOfItem: widget.foodItem.ingredients,
                  // )
                ],
              ),
            )),
          ),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          quantityControllerState.decrease();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Colors.grey.shade800)),
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
                        child: Material(
                          color: Colors.white,
                          child: Text(
                            quantityState.quantity.toString(),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          quantityControllerState.increase();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Colors.grey.shade800)),
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
                AddToCartButton(id: widget.id, price: widget.price)
              ],
            ),
          ),
        )
      ],
    );
  }

  // void toggleFavorite() {
  //   setState(() {
  //     favorite = !favorite;
  //   });
  //   if (favorite) {
  //     addFavorite();
  //   } else {
  //     removeFavorite();
  //   }
  // }

  // void addFavorite() {
  //   DatabaseHelper().addToFavorites(widget.foodItem.id);
  // }

  // void removeFavorite() {
  //   DatabaseHelper().removeFavorite(widget.foodItem.id);
  // }
}
