import 'package:flutter/material.dart';
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
      ref.read(favoriteFoodProvider.notifier).checkFavorite(widget.foodId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite =
        ref.watch(favoriteFoodProvider.select((value) => value.isFavorite));

    return FloatingActionButton.small(
      backgroundColor: Colors.white,
      onPressed: () async{
        isFavorite == true
            ?  ref
                .read(favoriteFoodProvider.notifier)
                .removeFavorite(widget.foodId)
            :  ref
                .read(favoriteFoodProvider.notifier)
                .addFavorite(widget.foodId);
         ref.read(favoriteFoodProvider.notifier).statusFavorite(isFavorite);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Icon(
        isFavorite ? Icons.favorite_rounded : Icons.favorite_border_outlined,
        color: Colors.pinkAccent,
      ),
    );
  }
}
