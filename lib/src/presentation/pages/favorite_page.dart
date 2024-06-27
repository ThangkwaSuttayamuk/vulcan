import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/favorite_food/favorite_food_provider.dart';
import 'package:flutter_application_1/src/presentation/widgets/list/favorite_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            AppLocalizations.of(context)?.favorite_header ?? 'My Likes',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: const Column(
          children: [
            SizedBox(
              height: 15,
            ),
            FavoriteList()
          ],
        ));
  }
}
