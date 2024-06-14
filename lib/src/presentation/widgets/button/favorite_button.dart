import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite/favorite_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteButton extends ConsumerStatefulWidget {
  final int foodId;
  const FavoriteButton({super.key, required this.foodId});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends ConsumerState<FavoriteButton> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favoriteProvider.notifier).checkFavorite(widget.foodId);
      ref.read(favoriteFoodProvider.notifier).fetchFavoriteFoods();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteState = ref.watch(favoriteProvider);
    final favoritelistState = ref.watch(favoriteFoodProvider);
    final favoriteFoodState = ref.read(favoriteFoodProvider.notifier);

    return FloatingActionButton.small(
      backgroundColor: Colors.white,
      onPressed: () {
        // toggleFavorite();
        // favoriteFoodState.removeFavorite(widget.foodId);
        // favoriteFoodState.addFavorite(widget.foodId);

        print(favoritelistState.favoriteFoods);
        favoriteState.isFavorite == true
            ? favoriteFoodState.removeFavorite(widget.foodId)
            : favoriteFoodState.addFavorite(widget.foodId);

        ref
            .read(favoriteProvider.notifier)
            .statusFavorite(favoriteState.isFavorite);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Icon(
        favoriteState.isFavorite
            ? Icons.favorite_rounded
            : Icons.favorite_border_outlined,
        color: Colors.pinkAccent,
      ),
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
}
