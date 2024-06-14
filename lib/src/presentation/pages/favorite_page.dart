import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_provider.dart';
import 'package:flutter_application_1/src/presentation/pages/food_detail_page.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favoriteFoodProvider.notifier).fetchFavoriteFoods();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoritelistState = ref.watch(favoriteFoodProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Likes',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey.shade800),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Column(
          children: [
            Expanded(
                child: favoritelistState.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : favoritelistState.error != null
                        ? Center(
                            child: Text('Error: ${favoritelistState.error}'))
                        : GridView.builder(
                            padding: const EdgeInsets.only(
                                bottom: 100, left: 20, right: 20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 40,
                              childAspectRatio:
                                  (MediaQuery.of(context).size.width /
                                          MediaQuery.of(context).size.height) /
                                      0.5,
                            ),
                            itemCount: favoritelistState.favoriteFoods.length,
                            itemBuilder: (context, index) {
                              final foodItem =
                                  favoritelistState.favoriteFoods[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              FoodDetail(
                                                
                                                id: foodItem.id,
                                                name: foodItem.name,
                                                description:
                                                    foodItem.description,
                                                price: foodItem.price,
                                                image: foodItem.image,
                                              )));
                                },
                                child: FoodCard(
                                  food: foodItem,
                                ),
                              );
                            },
                          ))
          ],
        ));
  }
}
