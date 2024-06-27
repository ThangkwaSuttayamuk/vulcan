import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/cart/cart_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/food/food_state.dart';
import 'package:flutter_application_1/src/presentation/controller/quantity/quantity_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/add_to_cart_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/button/favorite_button.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/text_card.dart';
import 'package:flutter_application_1/src/presentation/widgets/loading/shimmer_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FoodDetail extends ConsumerStatefulWidget {
  final int id;
  

  const FoodDetail({
    super.key,
    required this.id,
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
      ref.read(foodListProvider.notifier).getFoodById(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quantityState = ref.watch(quantityProvider);
    final quantityControllerState = ref.read(quantityProvider.notifier);
    final food = ref.watch(foodListProvider);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)?.detail_header ?? 'Items',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Consumer(builder: (BuildContext context, WidgetRef refHome,
                      Widget? widget) {
                    switch (food.status) {
                      case HomeStatus.loading:
                        return const DetailLoading();
                      case HomeStatus.success:
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
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
                                                'assets/images/${food.foodById?.image}'))),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: FavoriteButton(
                                          foodId: food.foodById?.id ?? 0)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    food.foodById?.name ?? '',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
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
                                      food.foodById?.description ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.color,
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
                                    AppLocalizations.of(context)
                                            ?.detail_ingredient ??
                                        'Ingredints:',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextCard(
                              listOfItem:
                                  food.foodById?.ingredients.split(',') ?? [],
                            )
                          ],
                        );
                      default:
                        return const Expanded(
                            child: Center(
                          child: Text('Not Found'),
                        ));
                    }
                  }),
                ],
              ),
            )),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          height: 100,
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Theme.of(context).colorScheme.secondary,
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
                          child: const Icon(
                            Icons.remove,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 50,
                        child: Material(
                          color: Theme.of(context).colorScheme.secondary,
                          child: Text(
                            quantityState.quantity.toString(),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    Material(
                      color: Theme.of(context).colorScheme.secondary,
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
                          child: const Icon(
                            Icons.add,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AddToCartButton(
                    id: widget.id, price: food.foodById?.price ?? 0.0)
              ],
            ),
          ),
        )
      ],
    );
  }
}
