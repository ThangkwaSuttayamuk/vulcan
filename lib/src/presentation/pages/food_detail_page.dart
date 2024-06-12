import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/domain/entities/food.dart';
import 'package:flutter_application_1/src/presentation/controller/quantity/quantity_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/favorite_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodDetail extends ConsumerStatefulWidget {
  final Food foodItem;
  const FoodDetail({
    super.key,
    required this.foodItem,
  });

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends ConsumerState<FoodDetail> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(quantityProvider.notifier).initData();
      // ref.read(quan)
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quantityState = ref.watch(quantityProvider);
    final quantityControllerState = ref.read(quantityProvider.notifier);
    // final quan
    

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
                                      'assets/images/${widget.foodItem.image}'))),
                        ),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: FavoriteButton(foodId: widget.foodItem.id)
                            // FloatingActionButton.small(
                            //   backgroundColor: Colors.white,
                            //   onPressed: () {
                            //     toggleFavorite();
                            //   },
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(30)),
                            //   child: Icon(
                            //     favorite
                            //         ? Icons.favorite_rounded
                            //         : Icons.favorite_border_outlined,
                            //     color: Colors.pink,
                            //   ),
                            // ),
                            ),
                        // FavoriteButton(foodId: widget.foodItem.id)
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.foodItem.name,
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
                            widget.foodItem.description,
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
                        'Add to Cart - \$${widget.foodItem.price}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
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
