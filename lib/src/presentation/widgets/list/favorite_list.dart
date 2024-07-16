import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_provider.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_state.dart';
import 'package:flutter_application_1/src/presentation/widgets/card/food_card.dart';
import 'package:flutter_application_1/src/presentation/widgets/loading/shimmer_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteList extends ConsumerStatefulWidget {
  const FavoriteList({super.key});

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends ConsumerState<FavoriteList> {
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
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 20.h,
                  mainAxisSpacing: 30.w,
                  maxCrossAxisExtent: 180.w,
                  mainAxisExtent: 170.h),
              itemCount: favoritelistState.favoriteFoods.length,
              itemBuilder: (context, index) {
                final foodItem = favoritelistState.favoriteFoods[index];
                return Material(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
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
                    ));
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
