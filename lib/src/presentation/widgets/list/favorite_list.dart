import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_state.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card.dart';
import 'package:flutter_application_1/src/presentation/widgets/loading/shimmer_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteList extends ConsumerWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritelistState = ref.watch(favoriteFoodProvider);

    return Consumer(
        builder: (BuildContext context, WidgetRef refHome, Widget? widget) {
      switch (favoritelistState.status) {
        case FavoriteFoodStatus.loading:
          return const Expanded(
            child: ShimmerView(
              length: 6,
            ),
          );
        case FavoriteFoodStatus.failure:
          return Expanded(
              child: Center(child: Text('Error: ${favoritelistState.error}')));
        case FavoriteFoodStatus.empty:
          return Expanded(
              child: Center(
            child: Text(
              AppLocalizations.of(context)?.favorite_empty ??
                  'No Favorite List',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ));
        case FavoriteFoodStatus.success:
          return Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 40,
                childAspectRatio: (MediaQuery.of(context).size.width /
                        MediaQuery.of(context).size.height) /
                    0.53,
              ),
              itemCount: favoritelistState.favoriteFoods.length,
              itemBuilder: (context, index) {
                final foodItem = favoritelistState.favoriteFoods[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail',
                      arguments: foodItem.id);
                  },
                  child: FoodCard(
                    id: foodItem.id,
                    name: foodItem.name,
                    description: foodItem.description,
                    price: foodItem.price,
                    ingredients: foodItem.ingredients,
                    image: foodItem.image,
                  ),
                );
              },
            ),
          );
        default:
          return const Expanded(
              child: Center(
            child: Text('Not Found'),
          ));
      }
    });
  }
}
